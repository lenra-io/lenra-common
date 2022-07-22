defmodule LenraCommon.Errors.ErrorStruct do
  @moduledoc """
    LenraCommon.Errors.ErrorStruct defines a basic error struct for Lenra server.
  """
  defmacro __using__(_opts) do
    quote do
      @derive {Jason.Encoder, only: [:message, :reason, :metadata]}
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
