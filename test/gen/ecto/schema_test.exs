defmodule Tub.Etco.SchemaTest do
  use ExUnit.Case
  alias Tub.Ecto.Schema
  require Schema

  test "generate an Ecto Schema" do
    name = "Acme.Schema.Block"

    fields = [
      {:height, :integer, null: false},
      {:hash, :string, null: false},
      {:gas, :integer, null: true}
    ]

    Schema.gen(name, "block", fields, {:id, :id}, "Ecto schema for Block")
  end
end
