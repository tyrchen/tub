defmodule Tub.Sql.CreateTableTest do
  use ExUnit.Case
  alias Tub.Sql.CreateTable

  test "generate a create table sql" do
    name = "Block"

    fields = [
      {:height, :integer, null: true},
      {:hash, :string, null: false},
      {:gas, :integer, null: true}
    ]

    assert "create table Block (\n  height integer,\n  hash string not null,\n  gas integer\n);" ==
             CreateTable.gen(name, fields)
  end
end
