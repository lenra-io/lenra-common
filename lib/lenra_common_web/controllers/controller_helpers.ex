defmodule LenraCommonWeb.ControllerHelpers do
  @moduledoc """
    ApplicationRunner.ControllerHelpers give some helper functions to assign error/data to the conn and send the response to the view.
  """

  def assign_error(%Plug.Conn{} = conn, error) do
    error
    |> case do
      %{valid?: false} ->
        conn
        |> Plug.Conn.put_status(400)
        |> add_error(error)

      %LenraCommon.Errors.TechnicalError{reason: :error_404} ->
        conn
        |> Plug.Conn.put_status(404)
        |> add_error(error)

      # Returned by bouncer
      :forbidden ->
        conn
        |> Plug.Conn.put_status(403)
        |> add_error(LenraCommon.Errors.forbidden())

      %LenraCommon.Errors.BusinessError{} ->
        conn
        |> Plug.Conn.put_status(400)
        |> add_error(error)

      %LenraCommon.Errors.TechnicalError{} ->
        conn
        |> Plug.Conn.put_status(400)
        |> add_error(error)

      %LenraCommon.Errors.DevError{} ->
        conn
        |> Plug.Conn.put_status(400)
        |> add_error(error)

      _error ->
        conn
        |> Plug.Conn.put_status(400)
        |> add_error(LenraCommon.Errors.bad_request())
    end
  end

  def add_error(%Plug.Conn{} = conn, error) do
    Plug.Conn.assign(conn, :error, error)
  end

  def assign_data(%Plug.Conn{} = conn, value) do
    Plug.Conn.assign(conn, :data, value)
  end

  def reply(%Plug.Conn{assigns: %{error: _}} = conn) do
    Phoenix.Controller.render(conn, "error.json")
  end

  def reply(%Plug.Conn{} = conn) do
    Phoenix.Controller.render(conn, "success.json")
  end
end
