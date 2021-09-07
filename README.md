# Idris2-Jupyter-Vega

A [Vega](https://github.com/vega/vega) display plugin for the [Idris 2 Jupyter kernel](https://github.com/madman-bob/idris2-jupyter).

Wraps the [`ipyvega`](https://github.com/vega/ipyvega/) library.

## Installation

Ensure that the [Idris 2 Jupyter kernel](https://github.com/madman-bob/idris2-jupyter)
is installed, in a sibling directory of this repository.

Install the [`ipyvega`](https://github.com/vega/ipyvega/) library.

Note that the `not needed in notebook >= 5.3` comment, in the `ipyvega` installation instructions, refers to the `--sys-prefix` flag, not the command as a whole.

Then run:

```bash
make install
```

## Displaying graphs

Run the Idris 2 kernel with the `idris2-jupyter-vega` and `contrib` packages available.

Import the `Idris2JupyterVega.VegaLite` and `Language.JSON` modules:
         
```idris2-repl
:module Idris2JupyterVega.VegaLite
:module Language.JSON
```

Construct a `VegaLite` object by passing a `JSON` object matching the VegaLite schema to `MkVegaLite`:

```idris2-repl
:let description : String
:let description = "A simple bar chart with embedded data."

:let vals : List (String, Double)
:let vals = [("A", 28), ("B", 55), ("C", 43), ("D", 91), ("E", 81), ("F", 53), ("G", 19), ("H", 87), ("I", 52)]

:let mkBarChart : String -> List (String, Double) -> VegaLite
:let mkBarChart description vals = MkVegaLite $ JObject [("$schema", JString "https://vega.github.io/schema/vega-lite/v5.json"), ("description", JString description), ("data", JObject [("values", JArray $ map (\(name, val) => JObject [("a", JString name), ("b", JNumber val)]) vals)]), ("mark", JString "bar"), ("encoding", JObject [("x", JObject [("field", JString "a"), ("type", JString "nominal"), ("axis", JObject [("labelAngle", JNumber 0)])]), ("y", JObject [("field", JString "b"), ("type", JString "quantitative")])])]
```

Execute the `display` function on the resultant `VegaLite` object:

```idris2-repl
:exec display $ mkBarChart description vals
```
