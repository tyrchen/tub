defmodule Tub.DynamicModuleTest do
  use ExUnit.Case
  alias Tub.DynamicModule
  require DynamicModule

  test "generate a dynamic module" do
    name = "Acme.Server"

    preamble =
      quote do
        use GenServer
      end

    contents =
      quote do
        def start_link, do: GenServer.start_link(Acme.Server, nil, name: Acme.Server)
        def hello, do: GenServer.call(Acme.Server, :hello)
        def init(_), do: {:ok, nil}
        def handle_call(:hello, _from, state), do: {:reply, "hello world", state}
      end

    DynamicModule.gen(name, preamble, contents, doc: "hello world")
    {:ok, _pid} = Acme.Server.start_link()
    assert "hello world" = Acme.Server.hello()
  end
end
