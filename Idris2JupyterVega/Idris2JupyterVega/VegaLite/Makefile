json-schema ?= ../../../../idris2-json-schema/build/exec/json-schema

V5.idr: v5.json Makefile
	$(json-schema) --module-name Idris2JupyterVega.VegaLite.V5 --schema-name VegaLite --json-casts v5.json
	mv v5.idr V5.idr

v5.json:
	wget https://vega.github.io/schema/vega-lite/v5.json

clean:
	$(RM) V5.idr
