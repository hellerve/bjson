module BJson where

import qualified Text.JSON as J

import Zepto.Types.Export

exports :: [(String, [LispVal] -> IOThrowsError LispVal, String)]
exports = [("decode", decodeJson, decodeJsonDoc)]

decodeJsonDoc :: String
decodeJsonDoc = "decodes zepto data structure to JSON"

decode J.JSNull = fromSimple $ Nil ""
decode (J.JSBool x) = fromSimple $ Bool x
decode (J.JSRational _ x) = fromSimple $ Number $ NumR x
decode (J.JSString x) = fromSimple $ String $ J.fromJSString x
decode (J.JSArray elems) = List $ map decode elems
decode (J.JSObject elems) = HashMap $ fromListMap
                                  $ map (\(x, y) -> (String x, decode y))
                                  $ J.fromJSObject elems

decodeJson :: [LispVal] -> IOThrowsError LispVal
decodeJson [SimpleVal (String src)] =
    case (J.decodeStrict src) :: J.Result J.JSValue of
      J.Ok json -> return $ decode json
      J.Error str -> lispErr $ Default str
decodeJson [x] = lispErr $ TypeMismatch "string" x
decodeJson x = lispErr $ NumArgs 1 x
