defmodule LenraCommonWeb.Test do
  use LenraCommon.Errors.Error, errors: [{:test, "test"}, {:other_test, "other_test"}]
end
