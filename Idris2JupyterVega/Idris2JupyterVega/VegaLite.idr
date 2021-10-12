module Idris2JupyterVega.VegaLite

import Data.String

import Language.JSON

import Python

import Jupyter

import public Idris2JupyterVega.VegaLite.V5 as Idris2JupyterVega.VegaLite

%default total

export
display : HasIO io => VegaLite -> io ()
display vegaLite = putStrLn $ "DisplayVegaLite " ++ show (assert_total $ cast {to = JSON} vegaLite)

export
data PythonVegaLite : Type where [external]

export
PrimPythonType PythonVegaLite where

export
HasIPythonReprMimeBundle PythonVegaLite where

%foreign "python: loads, json"
prim__py_json_loads : StringUTF8 -> PrimIO PythonDict

%foreign "python: VegaLite, vega"
prim__py_vegalite : PythonDict -> PrimIO PythonVegaLite

export
record RawVegaLite where
    constructor MkRawVegaLite
    json : String

export
Idris2Response RawVegaLite where
    parse s =
        if isPrefixOf "DisplayVegaLite " s
            then Just $ MkRawVegaLite $ snd $ break (== ' ') s
            else Nothing

export
JupyterResponse RawVegaLite where
    sendResponse response = do
        pyJson <- primIO $ prim__py_json_loads $ toUTF8 $ json response
        pyVegaLite <- primIO $ prim__py_vegalite pyJson
        sendResponse pyVegaLite
