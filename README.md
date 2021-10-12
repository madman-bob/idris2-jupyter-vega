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
import Idris2JupyterVega.VegaLite

export
barChart : String -> List (String, Double) -> VegaLite
barChart description vals = TopLevelSpec_0 $ MkTopLevelUnitSpec
    (Just "https://vega.github.io/schema/vega-lite/v5.json")
    Nothing Nothing Nothing Nothing Nothing Nothing
    (Data_0 $ Data_0 $ DataSource_1 $ MkInlineData Nothing Nothing $ InlineDataset_3 $ map (\(name, val) => JObject [("a", JString name), ("b", JNumber val)]) vals)
    Nothing
    (Just description)
    (Just $ MkFacetedEncoding
        Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing
        (Just $ PositionDef_0 $ MkPositionFieldDef
            Nothing
            (Just $ Axis_0 $ MkAxis Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing (Just $ LabelAngle_0 0) Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing)
            Nothing Nothing
            (Just $ Field_0 "a")
            Nothing Nothing Nothing Nothing Nothing Nothing
            (Just StandardTypeNominal)
        )
        Nothing Nothing Nothing
        (Just $ PositionDef_0 $ MkPositionFieldDef
            Nothing Nothing Nothing Nothing
            (Just $ Field_0 "b")
            Nothing Nothing Nothing Nothing Nothing Nothing
            (Just StandardTypeQuantitative)
        )
        Nothing Nothing Nothing
    )
    Nothing
    (AnyMark_2 MarkBar)
    Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing
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
