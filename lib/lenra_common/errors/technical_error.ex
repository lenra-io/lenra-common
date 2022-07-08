defmodule LenraCommon.Errors.TechnicalError do
  @moduledoc """
    LenraCommon.Errors.TechnicalError create all error function following the `@errors` list.
    For each errors in the list this modules create two function,
    one that create and return TechnicalError struct,
    the second create TechnicalError struct and return it into an tuple.
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
