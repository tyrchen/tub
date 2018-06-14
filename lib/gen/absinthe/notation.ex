defmodule Tub.Absinthe.Notation do
  @moduledoc """
  Generate Absinthe Notation

  Usage:

    fields = [
      f1: :string,
      f2: :integer,
      f3: :utc_datetime
    ]
    Tub.Absinthe.Notation.gen(Acme.Gql.Notation, [%{
      name: :block,
      fields: fields
    }])
  """
  alias Tub.DynamicModule
  require DynamicModule

  def gen(mod_name, schema, doc \\ false) do
    schema = transform(schema)

    preamble =
      quote do
        use Absinthe.Schema.Notation
      end

    contents =
      schema
      |> Enum.map(fn {object_name, fields} ->
        quote do
          object unquote(object_name) do
            unquote(get_fields(fields))
          end
        end
      end)

    DynamicModule.gen(mod_name, preamble, contents, doc)
  end

  defp transform(schema) do
    schema
    |> Enum.map(fn %{name: name, fields: fields} ->
      {name, fields}
    end)
  end

  defp get_fields(fields) do
    Enum.map(fields, fn {name, type} ->
      case is_list(type) do
        true ->
          [type] = type
          type = to_atom(type)

          quote do
            field(unquote(name), list_of(unquote(type)))
          end

        _ ->
          type = to_atom(type)

          quote do
            field(unquote(name), unquote(type))
          end
      end
    end)
  end

  defp to_atom(term) when is_atom(term), do: term
  defp to_atom(term) when is_binary(term), do: String.to_atom(term)
end
