defmodule LenraCommon.Errors do
  defmacro gen_errors(errors, module) do
    # See https://hexdocs.pm/elixir/Kernel.SpecialForms.html#quote/2-binding-and-unquote-fragments
    # to explain why we use bind_quoted
    quote bind_quoted: [errors: errors, module: module] do
      Enum.each(errors, fn {reason, message} ->
        fn_tuple = (Atom.to_string(reason) <> "_tuple") |> String.to_atom()

        def unquote(reason)(metadata \\ %{}) do
          %unquote(module){
            message: unquote(message),
            reason: unquote(reason),
            metadata: metadata
          }
        end

        def unquote(fn_tuple)(metadata \\ %{}) do
          {:error,
           %unquote(module){
             message: unquote(message),
             reason: unquote(reason),
             metadata: metadata
           }}
        end
      end)
    end
  end
end
