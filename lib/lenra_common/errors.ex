defmodule LenraCommon.Errors do
  @moduledoc """
    LenraCommon.Errors defines three error types to cover all of the possible errors.
  """
  alias LenraCommon.Errors.{BusinessError, TechnicalError}

  defdelegate forbidden, to: BusinessError, as: :forbidden

  defdelegate unknown_error, to: TechnicalError, as: :unknown_error
  defdelegate bad_request, to: TechnicalError, as: :bad_request
  defdelegate error_404, to: TechnicalError, as: :error_404
  defdelegate error_500, to: TechnicalError, as: :error_500
end
