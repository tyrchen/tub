defmodule Tub.Absinthe.NotationTest do
  use ExUnit.Case
  alias Tub.Absinthe.Notation
  require Notation

  test "generate a absinthe notation" do
    name = "Acme.Notation"

    schema = [
      %{name: :block, fields: [height: :integer, hash: :string, gas: :integer]},
      %{name: :transaction, fields: [height: :integer, hash: :string, gas: :integer]}
    ]

    Notation.gen(name, schema, "GQL schema for Block")
  end
end
