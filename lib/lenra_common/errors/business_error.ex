defmodule LenraCommon.Errors.BusinessError do
  @moduledoc """
    LenraCommon.Errors.BusinessError creates all error functions based on the `@errors` list.
    For each error in the list, this module creates two function,
    one that creates and returns a BusinessError struct,
    the second that creates a BusinessError struct and returns it into a tuple.
  """
  @errors [
    {:forbidden, "Forbidden"},
    {:nil_json, "JsonHelper cannot get in nil json."},
    {:integer_array_index, "You need to specify an integer to get an element of an array."}
  ]

  use LenraCommon.Errors.ErrorStruct
  use LenraCommon.Errors.ErrorGenerator, errors: @errors, module: __MODULE__

  def __errors__ do
    @errors
  end
end
