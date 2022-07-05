defmodule LenraCommon.Errors.BusinessError do
  defmacro __using__(opts) do
    quote do
      alias LenraCommon.Errors.BusinessError

      @type t() :: %__MODULE__{
              message: String.t(),
              reason: atom(),
              data: any()
            }

      @enforce_keys [:message, :reason]
      defexception [:message, :reason, :data]

      @errors unquote(Keyword.get(opts, :errors))

      @doc """
        This code takes care of generating each function corresponding to errors listed in the `@errors` array.
        It basically loops through the array and generates two functions for each error:
        - one that returns the error without metadata
        - one that returns the error with metadata.

        Here is an example. Imagine that the `@errors` array contains the following errors:
        ```
          [
            {:unknown_error, "Unknown error"},
          ]
        ```

        The following functions will be generated:
        ```
          def unknown_error() do
            %BusinessError{
              message: "Unknown error",
              reason: :unknown_error
            }
          end

          def unknown_error(metadata) do
            %BusinessError{
              message: "Unknown error",
              reason: :unknown_error,
              data: metadata
            }
          end
        ```
      """
      quote do
        Enum.each(@errors, fn {reason, message} ->
          def unquote(reason)() do
            %BusinessError{
              message: unquote(message),
              reason: unquote(reason)
            }
          end

          def unquote(reason)(metadata) do
            %BusinessError{
              message: unquote(message),
              reason: unquote(reason),
              data: metadata
            }
          end
        end)
      end
    end
  end
end
