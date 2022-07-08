defmodule LenraCommon.Errors.BusinessError do
  @moduledoc """
    LenraCommon.Errors.BusinessError creates all error functions based on the `@errors` list.
    For each error in the list, this module creates two function,
    one that creates and returns a BusinessError struct,
    the second that creates a BusinessError struct and returns it into a tuple.
  """

  use LenraCommon.Errors.Error

  @errors [
    {:forbidden, "Forbidden"}
  ]

  Enum.each(@errors, fn {reason, message} ->
    fn_tuple = (Atom.to_string(reason) <> "_tuple") |> String.to_atom()

    def unquote(reason)(metadata \\ %{}) do
      %__MODULE__{
        message: unquote(message),
        reason: unquote(reason),
        metadata: metadata
      }
    end

    def unquote(fn_tuple)(metadata \\ %{}) do
      {:error,
       %__MODULE__{
         message: unquote(message),
         reason: unquote(reason),
         metadata: metadata
       }}
    end
  end)
end
