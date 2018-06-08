defmodule Tub.Ecto.Schema do
  @moduledoc """
  Generate Ecto Schema

  Usage:

    fields = [
      f1: :string,
      f2: :integer,
      f3: :utc_datetime
    ]
    Tub.Ecto.Schema.gen(Acme.Block, "block", fields)
  """
  alias Tub.DynamicModule
  require DynamicModule

  def gen(mod_name, schema_name, fields, doc \\ false) do
    preamble =
      quote do
        use Ecto.Schema
      end

    contents =
      quote do
        schema unquote(schema_name) do
          unquote(get_fields(fields))
        end
      end

    DynamicModule.gen(mod_name, preamble, contents, doc)
  end

  defp get_fields(fields) do
    Enum.map(fields, fn {name, type} ->
      quote do
        field(unquote(name), unquote(type))
      end
    end)
  end
end
