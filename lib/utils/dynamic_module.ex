defmodule Tub.DynamicModule do
  @moduledoc """
  Generate a new module based on AST
  """
  defmacro gen(mod_name, preamble, contents, opts \\ []) do
    quote bind_quoted: [
            mod_name: mod_name,
            preamble: preamble,
            contents: contents,
            opts: opts
          ] do
      mod_doc = Access.get(opts, :doc, false)
      path = Access.get(opts, :path, "")

      moduledoc =
        quote do
          @moduledoc unquote(mod_doc)
        end

      name = String.to_atom("Elixir.#{mod_name}")

      Module.create(name, [moduledoc] ++ [preamble] ++ [contents], Macro.Env.location(__ENV__))

      case File.exists?(path) do
        false ->
          IO.puts("Module #{mod_name} is generated.")

        _ ->
          filename = Path.join(path, "#{mod_name}.ex")

          term =
            quote do
              defmodule unquote(name) do
                unquote(moduledoc)
                unquote(preamble)
                unquote(contents)
              end
            end

          term =
            term
            |> Macro.to_string()
            |> String.replace(~r/\(\s*\)/, "")

          File.write!(filename, term)
          IO.puts("Module #{mod_name} is generated and file gets created at #{filename}.")
      end
    end
  end
end
