check-requirements:
	uv --version 
.PHONY: check-requirements	


install: check-requirements
	uv python install
.PHONY: install	
