.PHONY: install dev build test

install:
	npm install

build:
	node esbuild.config.js

dev:
	node server/index.js

test:
	python3 -m pytest tests/ -v
