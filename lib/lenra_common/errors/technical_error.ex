defmodule LenraCommon.Errors.TechnicalError do
  @moduledoc """
    LenraCommon.Errors.TechnicalError creates all error functions based on the `@errors` list.
    For each error in the list, this module creates two function,
    one that creates and returns a TechnicalError struct,
    the second that creates a TechnicalError struct and returns it into an tuple.
  """
  use LenraCommon.Errors.Error

  @errors [
    {:unknown_error, "Unknown error"},
    {:bad_request, "Server cannot understand or process the request due to a client-side error."},
    {:error_404, "Not Found."},
    {:error_500, "Internal server error."}
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
