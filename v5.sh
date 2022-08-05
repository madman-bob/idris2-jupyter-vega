#!/bin/bash

wget https://vega.github.io/schema/vega-lite/v5.json
json-schema --module-name Idris2JupyterVega.VegaLite.V5 --schema-name VegaLite --json-casts v5.json
mv v5.idr Idris2JupyterVega/Idris2JupyterVega/VegaLite/V5.idr
rm v5.json
