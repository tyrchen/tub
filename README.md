# Tub

Tub is a code generator that helps you generate code from data to various schema. Right now it supports these libraries:

* [absinthe](#absinthe)
* [ecto](#ecto)
* [slate documentation](#slate)

## How does it work

```elixir
defmodule Abc.GenModules do
  fields = [
    f1: :string,
    f2: :integer,
    f3: :utc_datetime
  ]
  Tub.Ecto.Schema.gen(Abc.Db.Block, "block", fields)
  Tub.Absinthe.Notation.gen(Abc.Gql.Notation, [%{
    name: :block,
    fields: fields
  }])
end

```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tub` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tub, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/tub](https://hexdocs.pm/tub).
