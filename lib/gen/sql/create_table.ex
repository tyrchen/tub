defmodule Tub.Sql.CreateTable do
  @moduledoc """
  Generate create table SQL
  """

  @doc """
  Generate create table SQL
  """
  def gen(name, fields) do
    case fields do
      [] -> ""
      _ -> serialize_title(name) <> serialize_args(fields) <> "\n);"
    end
  end

  defp serialize_title(v), do: "create table #{v} (\n"

  defp serialize_args(items) do
    items
    |> Enum.map(&gen_field/1)
    |> Enum.join(",\n")
  end

  defp gen_field({name, type, meta}) do
    nullable =
      case Access.get(meta, :null, true) do
        true -> ""
        _ -> " not null"
      end

    "  #{transform_name(name)} #{type}#{nullable}"
  end

  defp transform_name(name) do
    # we shall quote all keywords here
    case name do
      "from" -> "\"from\""
      "to" -> "\"to\""
      _ -> name
    end
  end
end
