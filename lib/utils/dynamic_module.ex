defmodule Tub.DynamicModule do
  @moduledoc """
  Generate a new module based on AST
  """
  defmacro gen(mod_name, preamble, contents, mod_doc \\ false) do
    quote bind_quoted: [
            mod_name: mod_name,
            preamble: preamble,
            contents: contents,
            mod_doc: mod_doc
          ] do
      moduledoc =
        quote do
          @moduledoc unquote(mod_doc)
        end

      name = String.to_atom("Elixir.#{mod_name}")
      Module.create(name, [moduledoc] ++ [preamble] ++ [contents], Macro.Env.location(__ENV__))
    end
  end
end
