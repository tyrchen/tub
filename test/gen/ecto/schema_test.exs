defmodule Tub.Etco.SchemaTest do
  use ExUnit.Case
  alias Tub.Ecto.Schema
  require Schema

  test "generate an Ecto Schema" do
    name = "Acme.Schema.Block"
    fields = [height: :integer, hash: :string, gas: :integer]
    Schema.gen(name, "block", fields, "Ecto schema for Block")
  end
end
