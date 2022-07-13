defmodule LenraCommon.Errors.ErrorGenerator do
  @moduledoc """
    LenraCommon.Errors.Error defines a basic error struct for Lenra server.
  """
  defmacro __using__(opts) do
    errors = Keyword.get(opts, :errors, [])
    module = Keyword.fetch!(opts, :module)
    inherit = Keyword.get(opts, :inherit, false)

    quote do
      import LenraCommon.Errors.ErrorGenerator

      all_errors =
        if unquote(inherit),
          do: unquote(errors) ++ unquote(module).__errors__(),
          else: unquote(errors)

      gen_errors(all_errors, unquote(module))
    end
  end

  @doc """
    This code takes care of generating each function corresponding to errors listed in the `@errors` array.
    It basically loops through the array and generates two functions for each error:
    - one that returns the error without metadata
    - one that returns the error with metadata.

    Here is an example. Imagine that the `@errors` array contains the following errors:
    ```
      [
        {:unknown_error, "Unknown error"},
      ]
    ```

    The following functions will be generated:
    ```
      def unknown_error() do
        %BusinessError{
          message: "Unknown error",
          reason: :unknown_error
        }
      end

      def unknown_error(metadata) do
        %BusinessError{
          message: "Unknown error",
          reason: :unknown_error,
          data: metadata
        }
      end
    ```
  """
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
