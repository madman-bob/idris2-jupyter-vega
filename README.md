# Idris2-Jupyter-Vega

A [Vega](https://github.com/vega/vega) display plugin for the [Idris 2 Jupyter kernel](https://github.com/madman-bob/idris2-jupyter).

Wraps the [`ipyvega`](https://github.com/vega/ipyvega/) library.

## Installation

Ensure that the [Idris 2 Jupyter kernel](https://github.com/madman-bob/idris2-jupyter),
and the [Idris 2 JSON Schema tool](https://github.com/madman-bob/idris2-json-schema)
are installed, in a sibling directory of this repository.

Install the [`ipyvega`](https://github.com/vega/ipyvega/) library.

Note that the `not needed in notebook >= 5.3` comment, in the `ipyvega` installation instructions, refers to the `--sys-prefix` flag, not the command as a whole.

Then run:

```bash
make install
```

## Displaying graphs

Run the Idris 2 kernel with the `idris2-jupyter-vega` and `contrib` packages available.

Construct a `VegaLite` object:

```idris
import Language.JSON
import Idris2JupyterVega.VegaLite

export
barChart : String -> List (String, Double) -> VegaLite
barChart description vals = TopLevelSpec_0 $ MkTopLevelUnitSpec
    {Schema = Just "https://vega.github.io/schema/vega-lite/v5.json"}
    (Data_0 $ Data_0 $ DataSource_1 $ MkInlineData $ InlineDataset_3 $ map (\(name, x) => JObject [("a", JString name), ("b", JNumber x)]) vals)
    {description = Just description}
    {encoding = Just $ MkFacetedEncoding
        {x = Just $ PositionDef_0 $ MkPositionFieldDef
            {axis = Just $ Axis_0 $ MkAxis {labelAngle = Just $ LabelAngle_0 0}}
            {field = Just $ Field_0 "a"}
            {type = Just StandardTypeNominal}
        }
        {y = Just $ PositionDef_0 $ MkPositionFieldDef
            {field = Just $ Field_0 "b"}
            {type = Just StandardTypeQuantitative}
        }
    }
    (AnyMark_2 MarkBar)
```

Import the `Idris2JupyterVega.VegaLite` and `Language.JSON` modules, as well as any of your own definitions:

```idris2-repl
:module Idris2JupyterVega.VegaLite
:module Language.JSON

:let description : String
:let description = "A simple bar chart with embedded data."

:let vals : List (String, Double)
:let vals = [("A", 28), ("B", 55), ("C", 43), ("D", 91), ("E", 81), ("F", 53), ("G", 19), ("H", 87), ("I", 52)]
```

Execute the `display` function on your `VegaLite` object:

```idris2-repl
:exec display $ barChart description vals
```
