defmodule LenraCommon.Errors do
  @moduledoc """
    LenraCommon.Errors manage common errors.
  """
  require Logger

  def log(error) when is_struct(error) do
    [
      error.message,
      "\n",
      format_stacktrace(Process.info(self(), :current_stacktrace)),
      "\n"
    ]
    |> Enum.join()
    |> Logger.error()
  end

  def log(error) do
    [
      to_string(error),
      "\n",
      format_stacktrace(Process.info(self(), :current_stacktrace)),
      "\n"
    ]
    |> Enum.join()
    |> Logger.error()
  end

  defp format_stacktrace({:current_stacktrace, stacktrace}) do
    stacktrace
    |> Enum.map_join(&format_stacktrace_line/1, "\n")
  end

  defp format_stacktrace_line({module, method, argNum, [file: file, line: line]}) do
    "\t#{file}:#{line} #{module}.#{method}/#{argNum}"
  end
end
