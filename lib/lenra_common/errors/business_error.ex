defmodule LenraCommon.Errors.BusinessError do
  @type t() :: %__MODULE__{
          message: String.t(),
          reason: atom(),
          data: any()
        }

  @enforce_keys [:message, :reason]
  defexception [:message, :reason, :data]

  @errors [
    {:forbidden, "Forbidden"}
  ]

  Enum.each(@errors, fn {reason, message} ->
    def unquote(reason)() do
      %__MODULE__{
        message: unquote(message),
        reason: unquote(reason)
      }
    end

    def unquote(reason)(metadata) do
      %__MODULE__{
        message: unquote(message),
        reason: unquote(reason),
        data: metadata
      }
    end
  end)
end
