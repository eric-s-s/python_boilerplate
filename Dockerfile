ARG UV_VERSION
ARG PYTHON_VERSION
ARG DEV_IMAGE=python:${PYTHON_VERSION}-slim
ARG APP_IMAGE=python:${PYTHON_VERSION}-slim

ARG BUILD_WORKDIR=/build
ARG INSTALL_WORKDIR=/install
ARG APP_WORKDIR=/app

ARG VENV_DIR=/venv
ARG INSTALL_SITE_PACKAGES_DIR=/install-site-packages
ARG APP_SITE_PACKAGES_DIR=/app-site-packages

#################
FROM ghcr.io/astral-sh/uv:${UV_VERSION} AS uv-stage


#################
FROM ${DEV_IMAGE} AS build-stage
ARG BUILD_WORKDIR
COPY --from=uv-stage /uv /uvx /bin/
WORKDIR ${BUILD_WORKDIR}

COPY . .

RUN uv build --no-cache
RUN uv sync --locked --no-install-project --no-dev
RUN uv pip freeze > requirements.txt


#################
FROM ${DEV_IMAGE} AS install-stage

ARG BUILD_WORKDIR
ARG INSTALL_WORKDIR
ARG INSTALL_SITE_PACKAGES_DIR

COPY --from=uv-stage /uv /uvx /bin/
WORKDIR ${INSTALL_WORKDIR}
COPY --from=build-stage ${BUILD_WORKDIR}/dist ./dist
COPY --from=build-stage ${BUILD_WORKDIR}/requirements.txt .


RUN uv pip install -r requirements.txt --target ${INSTALL_SITE_PACKAGES_DIR}
RUN uv pip install --no-cache-dir dist/*.whl --target ${INSTALL_SITE_PACKAGES_DIR}

##############
FROM ${APP_IMAGE} AS run-stage


ARG APP_WORKDIR
ARG INSTALL_SITE_PACKAGES_DIR
ARG APP_SITE_PACKAGES_DIR
WORKDIR ${APP_WORKDIR}

COPY --chmod=775 --from=install-stage "${INSTALL_SITE_PACKAGES_DIR}" "${APP_SITE_PACKAGES_DIR}"
ENV PYTHONPATH="${APP_SITE_PACKAGES_DIR}:$PYTHONPATH"
ENV PATH="${APP_SITE_PACKAGES_DIR}/bin:$PATH"
ENTRYPOINT ["python"]
