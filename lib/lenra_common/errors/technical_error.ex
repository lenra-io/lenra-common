defmodule LenraCommon.Errors.Error do
  defmacro __using__(opts) do
    errors = Keyword.get(opts, :errors)

    quote do
      @type t() :: %__MODULE__{
              message: String.t(),
              reason: atom(),
              data: any()
            }

      @enforce_keys [:message, :reason]
      defexception [:message, :reason, :data]

      Enum.each(unquote(errors), fn {reason, message} ->
        quote do
          def unquote(reason)() do
            %TechnicalError{
              message: unquote(message),
              reason: unquote(reason)
            }
          end

          def unquote(reason)(metadata) do
            %TechnicalError{
              message: unquote(message),
              reason: unquote(reason),
              data: metadata
            }
          end
        end
      end)

      @doc """
        See Lenra.Errors.BusinessError for more information.
      """
    end
    |> IO.inspect()
  end
end
