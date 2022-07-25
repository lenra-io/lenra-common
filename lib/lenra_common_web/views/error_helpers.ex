defmodule LenraCommonWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """
  alias LenraCommon.Errors.{BusinessError, DevError, TechnicalError}

  def translate_error(%{errors: errors}) do
    translate_ecto_error(Enum.at(errors, 0))
  end

  def translate_error(%BusinessError{reason: reason, message: message}) do
    %{"message" => message, "reason" => reason}
  end

  def translate_error(%TechnicalError{reason: reason, message: message}) do
    %{"message" => message, "reason" => reason}
  end

  def translate_error(%DevError{reason: reason, message: message}) do
    %{"message" => message, "reason" => reason}
  end

  def translate_error(_err) do
    %{"message" => "An unknown error occured.", "reason" => "unknow format"}
  end

  def translate_ecto_error({field, {msg, opts}}) do
    error =
      Enum.reduce(opts, "#{field} #{msg}", fn
        {_key, {:parameterized, _, _}}, acc -> acc
        {key, value}, acc -> String.replace(acc, "%{#{key}}", to_string(value))
      end)

    error
  end
end
