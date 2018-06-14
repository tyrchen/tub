defmodule Tub.Sql.CreateTableTest do
  use ExUnit.Case
  alias Tub.Sql.CreateTable

  test "generate a create table sql" do
    name = "Block"
    fields = [height: :integer, hash: :string, gas: :integer]

    assert "create table Block (\n  height integer,\n  hash string,\n  gas integer\n);" ==
             CreateTable.gen(name, fields)
  end
end
