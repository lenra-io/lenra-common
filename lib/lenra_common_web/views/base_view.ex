defmodule LenraCommonWeb.BaseView do

  defmacro __using__(_opts) do
    quote do
      require Logger

      # def render("success.json", %{}) do
      #   %{"ok" => "200"}
      # end

      def render("success.json", %{data: data}) do
        %{
          "success" => true,
          "data" => data
        }
      end

      def render("success.json", _no_data) do
        %{
          "success" => true
        }
      end

      def render("error.json", %{errors: errors}) do
        %{"errors" => translate_errors(errors), "success" => false}
      end
    end
  end

end
