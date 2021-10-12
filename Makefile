.PHONY: idris2-jupyter-vega install

idris2-python = cd ../idris2-python && ./build/exec/idris2-python
json-schema ?= $(CURDIR)/../idris2-json-schema/build/exec/json-schema

export json-schema

idris2-jupyter-vega: build/ttc/Idris2JupyterVega

build/ttc/Idris2JupyterVega: idris2-jupyter-vega.ipkg Idris2JupyterVega/* Idris2JupyterVega/*/* Idris2JupyterVega/*/*/*
	make -C Idris2JupyterVega/Idris2JupyterVega/VegaLite V5.idr
	$(idris2-python) --install ../idris2-jupyter-vega/idris2-jupyter-vega.ipkg

install: idris2-jupyter-vega
	make -C ../idris2-jupyter add-plugin module="Idris2JupyterVega.VegaLite" plugin="RawVegaLite" packages="idris2-jupyter-vega contrib" install
