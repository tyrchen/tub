defmodule Tub.Absinthe.Schema do
  @moduledoc """
  Generate Absinthe Schema

  Usage:

  ```elixir
  name = "q1"
  doc = "hello world"
    params = [
  	{:f1, :string, nullable: false, doc: "arg1"},
  	{:f1, :string, nullable: true, doc: "arg2"},
  ]
  return = :list_blocks
  meta = notation: "OcapApi.GQL.Notation.Bitcoin", resolver: "OcapApi.GQL.Bitcoin.Resolver"
  Tub.Absinthe.Schema.gen(mod_name, [name, doc, params, return], meta)
  ```
  """
  alias Tub.DynamicModule
  require DynamicModule

  def gen(mod_name, queries, meta, mod_doc \\ "") do
    notation = name_to_module(meta[:notation])
    resolver = name_to_module(meta[:resolver])
    IO.puts("Module: #{mod_name}, notation: #{notation}, resolver: #{resolver}")

    preamble =
      quote do
        use Absinthe.Schema
        import_types(unquote(notation))

        alias unquote(resolver)
      end

    data = transform(queries)

    contents =
      quote do
        query do
          unquote(data)
        end
      end

    DynamicModule.gen(mod_name, preamble, contents, mod_doc)
  end

  defp name_to_module(name), do: String.to_atom("Elixir.#{name}")

  defp transform(queries) do
    queries
    |> Enum.map(fn data ->
      {field_name, filed_doc, params, return} = data

      IO.puts(
        "Creating #{field_name}: please make sure you define resolver function #{return} in your resolver."
      )

      quote do
        @desc unquote(filed_doc)
        field unquote(field_name), unquote(return) do
          unquote(get_params(params))

          resolve(fn parent, args, resolution ->
            apply(Resolver, unquote(return), [parent, args, resolution])
          end)
        end
      end
    end)
  end

  defp get_params(params) do
    Enum.map(params, fn {name, type, meta} ->
      case meta[:nullable] do
        false ->
          quote do
            @desc unquote(meta[:doc])
            arg(unquote(name), non_null(unquote(type)))
          end

        _ ->
          quote do
            @desc unquote(meta[:doc])
            arg(unquote(name), unquote(type))
          end
      end
    end)
  end
end
