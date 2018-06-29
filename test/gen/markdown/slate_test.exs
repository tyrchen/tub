defmodule Tub.Markdown.SlateTest do
  use ExUnit.Case
  alias Tub.Markdown.Slate

  test "generate a slate markdown file" do
    data = [
      %{
        "name" => "ethereum",
        "apis" => [
          %{
            "doc" => "The chain query allows you to retrieve information of a chain.",
            "examples" => [
              "```javascript\n{}\n```\n"
            ],
            "params" => [
              %{
                "doc" => "The name of the chain's built-in coin, such as btc, eth and so on.",
                "name" => "coin",
                "type" => "string"
              }
            ],
            "return" => "Blockchain",
            "name" => "Blockchain API"
          }
        ],
        "types" => [
          %{
            "doc" => "The Blockchain data structure tells general information of a chain.",
            "name" => "Blockchain",
            "properties" => [
              %{
                "doc" =>
                  "The name of the built-in coin of the chain, such as btc, eth, and so on.",
                "name" => "coin",
                "type" => "string"
              },
              %{
                "doc" => "The name of the chain, such as *main*, *test* and so on.",
                "name" => "name",
                "type" => "string"
              }
            ]
          }
        ]
      }
    ]

    Slate.gen(data)
  end
end
