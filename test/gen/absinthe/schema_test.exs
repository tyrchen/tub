defmodule Tub.Absinthe.SchemaTest do
  use ExUnit.Case
  alias Tub.Absinthe.Notation
  require Notation
  alias Tub.Absinthe.Schema
  require Schema

  test "generate a absinthe schema" do
    name = "Acme.Notation"

    fields = [
      {:height, :integer, nullable: false}
    ]

    schema = [
      {:block, fields, "object", ""}
    ]

    Notation.gen(name, schema, doc: "GQL schema for Block")

    name = "Acme.Schema"

    params = [
      {:height, :integer, nullable: false, doc: "arg1"},
      {:hash, :string, nullable: false, doc: "arg2"},
      {:gas, :integer, nullable: true, doc: "arg1"}
    ]

    return = :block

    meta = [notation: "Acme.Notation", resolver: "Acme.Resolver"]
    Schema.gen(name, [{:q1, "hello", params, return}], meta)
  end
end
