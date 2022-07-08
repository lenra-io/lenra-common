defmodule LenraCommon.Errors.Error do
  @moduledoc """
    LenraCommon.Errors.Error define basic error struct for Lenra server.
  """
  defmacro __using__(_opts) do
    quote do
      @type t() :: %__MODULE__{
              message: String.t(),
              reason: atom(),
              metadata: any()
            }

      @enforce_keys [:message, :reason]
      defexception [:message, :reason, :metadata]
    end
  end
end