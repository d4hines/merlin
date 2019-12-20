(enabled_if (>= %{ocaml_version} 4.07.0))

A few simple tests that show all the things we want to preserve or improve:

# To improve

- Presence of double underscores.

  $ echo "" | $MERLIN single search-by-polarity -query "-float +int64" \
  > -position 1:0 -filename test.ml | \
  > jq '.value.entries[] | del(.info) | del(.kind)'
  {
    "name": "Stdlib__int64.bits_of_float",
    "desc": "float -> int64",
    "deprecated": false
  }
  {
    "name": "Stdlib__int64.of_float",
    "desc": "float -> int64",
    "deprecated": false
  }

- Duplicated elements

  $ echo "" | $MERLIN single search-by-polarity -safe-string \
  > -query "-int +string" -position 1:0 -filename test.ml | \
  > head -n16
  {
    "class": "return",
    "value": {
      "entries": [
        {
          "name": "string_of_int",
          "kind": "Value",
          "desc": "int -> string",
          "info": "",
          "deprecated": false
        },
        {
          "name": "string_of_int",
          "kind": "Value",
          "desc": "int -> string",
          "info": "",

# To keep

- Lower bound on function arity

  $ echo "" | $MERLIN single search-by-polarity \
  > -query "-float +fun +fun +float" -position 1:0 -filename test.ml | \
  > tr '\n' ' ' | jq '.value.entries[] | del(.info) | del(.kind)' | head -n48
  {
    "name": "**",
    "desc": "float -> float -> float",
    "deprecated": false
  }
  {
    "name": "**",
    "desc": "float -> float -> float",
    "deprecated": false
  }
  {
    "name": "*.",
    "desc": "float -> float -> float",
    "deprecated": false
  }
  {
    "name": "*.",
    "desc": "float -> float -> float",
    "deprecated": false
  }
  {
    "name": "+.",
    "desc": "float -> float -> float",
    "deprecated": false
  }
  {
    "name": "+.",
    "desc": "float -> float -> float",
    "deprecated": false
  }
  {
    "name": "-.",
    "desc": "float -> float -> float",
    "deprecated": false
  }
  {
    "name": "-.",
    "desc": "float -> float -> float",
    "deprecated": false
  }
  {
    "name": "/.",
    "desc": "float -> float -> float",
    "deprecated": false
  }
  {
    "name": "/.",
    "desc": "float -> float -> float",
