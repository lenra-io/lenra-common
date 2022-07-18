defmodule LenraCommon.Errors.DevError do
  @moduledoc """
    LenraCommon.Errors.DevErrors Define the DevError structure.
    This is the error to raise when we are facing an impossible case (a case that should never happen).
    This error should be catched into sentry.
  """

  use LenraCommon.Errors.ErrorStruct
end
