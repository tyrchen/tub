defmodule Tub.Markdown.Slate do
  @moduledoc """
  Generate schema data into slate markdown
  """

  @dn "\n\n"

  @doc """
  Generate predefined data into slate markdown
  """
  def gen(data) do
    data
    |> Enum.map(fn item ->
      name = item["name"]
      types = serialize(item, :types)
      apis = serialize(item, :apis)

      {name, "# Data Structure#{@dn}#{types}#{@dn}#{apis}#{@dn}"}
    end)
  end

  defp serialize(data, type) do
    data
    |> Map.get(Atom.to_string(type))
    |> Enum.map(&serialize_one(&1, type))
    |> Enum.join(@dn)
  end

  defp serialize_one(item, :types) do
    serialize_title(item["name"]) <>
      serialize_doc(item["doc"]) <> serialize_args(item["properties"])
  end

  defp serialize_one(item, :apis) do
    serialize_title(item["name"], 1) <>
      serialize_doc(item["doc"]) <>
      serialize_examples(Map.get(item, "examples", [])) <>
      serialize_args(Map.get(item, "params", [])) <> serialize_response(item["return"])
  end

  defp serialize_title(v, level \\ 2), do: "#{String.duplicate("#", level)} #{v}#{@dn}"
  defp serialize_doc(v), do: "#{v}#{@dn}"

  defp serialize_args(items, name \\ "Property") do
    body =
      items
      |> Enum.map(fn p -> "#{p["name"]} | #{p["type"]} | #{p["doc"]}" end)
      |> Enum.join("\n")

    "#{@dn}#{name} | Type | Description\n-------- | ---- | -----------\n#{body}#{@dn}"
  end

  defp serialize_examples(examples), do: Enum.join(examples, @dn)

  defp serialize_response(response) do
    "## Return Object#{@dn}[#{response}](##{String.downcase(response)})"
  end
end
