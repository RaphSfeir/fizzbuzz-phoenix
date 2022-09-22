defmodule FizzbuzzWeb.ErrorView do
  use FizzbuzzWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  def render("400.html", %{message: message}) do
    "Bad Request Params: #{message}"
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
