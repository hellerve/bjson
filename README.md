# bjson

`bjson` is a small JSON decoder for zepto. It wraps Haskell's `Text.JSON`.

# Installation

```
zeps install hellerve/bjson
```

## Usage

```clojure
(load "bjson/bjson")
(import-all "bjson")

(json:decode "{\"hello\": \"json\"}")
; => #{hello json}

; wrapper around decode->catch-error
(json:decode? "invalid-json")
; => <error: Invalid JSON: a JSON text a serialized object or array at the top level.>
```

<hr/>

Have fun!
