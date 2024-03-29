PYTHON?=python3
VENV_PATH?=venv
MANPAGE ?= docs/torf.1
MANPAGE_HTML ?= docs/torf.1.html
MANPAGE_SRC ?= docs/torf.1.asciidoc

.PHONY: clean man release

clean:
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete
	rm -rf dist build
	rm -rf .pytest_cache .cache
	rm -rf $(MANDIR)
	rm -rf "$(VENV_PATH)"
	rm -rf .tox

venv:
	"$(PYTHON)" -m venv "$(VENV_PATH)"
	"$(VENV_PATH)"/bin/pip install --editable '.[dev]'

man:
	asciidoctor $(MANPAGE_SRC) -o $(MANPAGE) --doctype=manpage --backend=manpage
	asciidoctor $(MANPAGE_SRC) -o $(MANPAGE_HTML) --doctype=manpage --backend=html

release: man
	pyrelease CHANGELOG ./torfcli/_vars.py
