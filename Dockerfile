ARG UV_VERSION
ARG DEV_IMAGE=python:3.13-slim
ARG APP_IMAGE=gcr.io/distroless/python3
ARG APP_IMAGE=python:3.13-slim

ARG BUILD_WORKDIR=/build
ARG INSTALL_WORKDIR=/install
ARG APP_WORKDIR=/app

# When we copy over the virtualenv from install stage
# to run stage, we want to keep the same directory
# structure or it will not work
ARG VENV_DIR=/venv

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
ARG VENV_DIR

COPY --from=uv-stage /uv /uvx /bin/
WORKDIR ${INSTALL_WORKDIR}
COPY --from=build-stage ${BUILD_WORKDIR}/dist ./dist
COPY --from=build-stage ${BUILD_WORKDIR}/requirements.txt .

ENV PATH="${VENV_DIR}/bin:$PATH"
RUN uv venv ${VENV_DIR}

RUN uv pip install -r requirements.txt
RUN uv pip install --no-cache-dir dist/*.whl

##############
FROM ${APP_IMAGE} AS run-stage


ARG APP_WORKDIR
ARG VENV_DIR
WORKDIR ${APP_WORKDIR}

COPY --chmod=775 --from=install-stage "${VENV_DIR}" "${VENV_DIR}"
ENV PATH="${VENV_DIR}/bin:$PATH"
