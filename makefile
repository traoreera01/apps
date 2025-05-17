
.PHONY:
	run plugin

run:
	@cd src && poetry run python main.py

plugin:
	@poetry run python plugin.py