defmodule LenraCommonWeb.FallbackController do
  use LenraCommonWeb, :controller

  require Logger

  def call(conn, {:error, reason}) do
    Logger.debug("#{conn.method} #{conn.request_path} respond error: #{reason}")

    conn
    |> assign_error(reason)
    |> reply
  end

  def call(conn, {:error, _error, reason, _reason}) do
    Logger.debug("#{conn.method} #{conn.request_path} respond error: #{reason}")

    conn
    |> assign_error(reason)
    |> reply
  end
end
