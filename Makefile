check-requirements:
	uv --version 
.PHONY: check-requirements	


install: check-requirements
	uv python install
	uv sync --locked --all-groups
.PHONY: install	

upgrade:
	uv lock --upgrade
.PHONY: upgrade	
