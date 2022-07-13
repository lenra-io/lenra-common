defmodule LenraCommon.Errors.BusinessError do
  @moduledoc """
    LenraCommon.Errors.BusinessError creates all error functions based on the `@errors` list.
    For each error in the list, this module creates two function,
    one that creates and returns a BusinessError struct,
    the second that creates a BusinessError struct and returns it into a tuple.
  """

  use LenraCommon.Errors.Error
  import LenraCommon.Errors

  @errors [
    {:forbidden, "Forbidden"}
  ]

  def __errors__ do
    @errors
  end

  gen_errors(@errors, __MODULE__)
end
