defmodule LenraCommonWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  defmacro __using__(opts) do
    quote do
      @errors unquote(Keyword.get(opts, :errors))

      def translate_errors([]), do: []
      def translate_errors([err | errs]), do: translate_error(err) ++ translate_errors(errs)

      def translate_error(%Ecto.Changeset{errors: errors}) do
        Enum.map(errors, &translate_ecto_error/1)
      end

      def translate_error(err) when is_atom(err) do
        [Keyword.get(@errors, err, %{code: 0, message: "Unknown error"})]
      end

      def translate_ecto_error({field, {msg, opts}}) do
        message =
          Enum.reduce(opts, "#{field} #{msg}", fn
            {_key, {:parameterized, _, _}}, acc -> acc
            {key, value}, acc -> String.replace(acc, "%{#{key}}", to_string(value))
          end)

        %{code: 0, message: message}
      end

    end
  end

end
