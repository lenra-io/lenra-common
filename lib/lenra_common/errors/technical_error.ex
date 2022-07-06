defmodule LenraCommon.Errors.TechnicalError do
  @type t() :: %__MODULE__{
          message: String.t(),
          reason: atom(),
          data: any()
        }

  @enforce_keys [:message, :reason]
  defexception [:message, :reason, :data]

  @errors [
    {:unknown_error, "Unknown error"},
    {:bad_request, "Server cannot understand or process the request due to a client-side error."},
    {:error_404, "Not Found."},
    {:error_500, "Internal server error."}
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
