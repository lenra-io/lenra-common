defmodule LenraCommon.Errors.ErrorGenerator do
  @moduledoc """
    LenraCommon.Errors.Error defines a basic error struct for Lenra server.
  """
  defmacro __using__(opts) do
    errors = Keyword.get(opts, :errors, [])
    module = Keyword.fetch!(opts, :module)

    quote do
      import LenraCommon.Errors

      gen_errors(unquote(errors), unquote(module))
    end
  end
end
