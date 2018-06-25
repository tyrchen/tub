defmodule Tub.Absinthe.NotationTest do
  use ExUnit.Case
  alias Tub.Absinthe.Notation
  require Notation

  test "generate a absinthe notation" do
    name = "Acme.Notation"

    fields = [
      {:height, :integer, false},
      {:hash, :string, false},
      {:gas, :integer, true}
    ]

    schema = [
      %{name: :block, fields: fields},
      %{name: :transaction, fields: fields}
    ]

    Notation.gen(name, schema, "GQL schema for Block")
  end
end
