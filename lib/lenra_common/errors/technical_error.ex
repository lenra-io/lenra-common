defmodule LenraCommon.Errors.TechnicalError do
  @moduledoc """
    LenraCommon.Errors.TechnicalError creates all error functions based on the `@errors` list.
    For each error in the list, this module creates two function,
    one that creates and returns a TechnicalError struct,
    the second that creates a TechnicalError struct and returns it into an tuple.
  """
  use LenraCommon.Errors.Error

  import LenraCommon.Errors

  @errors [
    {:unknown_error, "Unknown error"},
    {:bad_request, "Server cannot understand or process the request due to a client-side error."},
    {:error_404, "Not Found."},
    {:error_500, "Internal server error."}
  ]

  def __errors__ do
    @errors
  end

  gen_errors(@errors, __MODULE__)
end
