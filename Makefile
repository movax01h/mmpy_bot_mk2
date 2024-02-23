ROOT_DIR := .

.PHONY: help install install_pre_commit_hooks install_deps run lint clean clean-build clean-pyc release sphinx venv
.DEFAULT_GOAL := help

help:  ## 💬 This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: venv install_pre_commit_hooks install_deps  ## 📦 Install all

install_pre_commit_hooks:  ## 📦 Install pre-commit hooks
	python3 -m venv $(ROOT_DIR)/.venv
	. $(ROOT_DIR)/.venv/bin/activate && pip install pre-commit && pre-commit install

install_deps:  ## 📦 Install mmpy_bot_mk2 dependencies
	. $(ROOT_DIR)/.venv/bin/activate && pip install -r requirements.txt
	. $(ROOT_DIR)/.venv/bin/activate && pip install -r dev-requirements.txt
	pip install .

run: venv  ## 🚀 Run mmpy_bot_mk2
	mmpy_bot_mk2

lint:  ## 📜 Lint & format, will try to fix errors and modify code
	@flake8 mmpy_bot_mk2 --exclude=mmpy_bot_mk2/settings.py

clean: clean-build clean-pyc  ## 🧹 Remove all build, test, coverage and Python artifacts

clean-build:  ## 🧹 Remove build artifacts
	@rm -fr build/
	@rm -fr dist/
	@rm -fr *.egg-info

clean-pyc:  ## 🧹 Remove Python file artifacts
	@find . -name '*.pyc' -exec rm -f {} +
	@find . -name '*.pyo' -exec rm -f {} +
	@find . -name '*~' -exec rm -f {} +

build: clean  ## 🏗️ Build source distribution
	@python setup.py sdist
	@ls -l dist
	
release: clean  ## 🚀 Release app into PyPi
	@python setup.py sdist bdist_wheel
	@twine upload dist/*

sphinx:  ## 📚 Build sphinx documentation
	@rm -rf ./docs/.build/html/
	@cd docs && sphinx-build -b html -d .build/doctrees . .build/html
	@xdg-open docs/.build/html/index.html >& /dev/null || open docs/.build/html/index.html >& /dev/null || true


# ============================================================================

venv: $(ROOT_DIR)/.venv/touchfile

$(ROOT_DIR)/.venv/touchfile:
	python3 -m venv $(ROOT_DIR)/.venv
	. $(ROOT_DIR)/.venv/bin/activate;
	touch $(ROOT_DIR)/.venv/touchfile
