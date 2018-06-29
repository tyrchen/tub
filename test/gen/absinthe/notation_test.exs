defmodule Tub.Absinthe.NotationTest do
  use ExUnit.Case
  alias Tub.Absinthe.Notation
  require Notation

  test "generate a absinthe notation" do
    name = "Acme.NotationNew"

    fields = [
      {:height, :integer, nullable: false},
      {:hash, :string, nullable: false},
      {:gas, :integer, nullable: true}
    ]

    schema = [
      {:block, fields, "input", ""},
      {:transaction, fields, "object", ""}
    ]

    Notation.gen(name, schema, doc: "GQL schema for Block")
  end
end
