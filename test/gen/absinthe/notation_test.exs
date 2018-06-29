defmodule Tub.Absinthe.NotationTest do
  use ExUnit.Case
  alias Tub.Absinthe.Notation
  require Notation

  test "generate a absinthe notation" do
    name = "Acme.Notation"

    fields = [
      {:height, :integer, null: false},
      {:hash, :string, null: false},
      {:gas, :integer, null: true}
    ]

    schema = [
      {:block, fields, "input", ""},
      {:transaction, fields, "object", ""}
    ]

    Notation.gen(name, schema, "GQL schema for Block")
  end
end
