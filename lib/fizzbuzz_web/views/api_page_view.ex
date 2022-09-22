defmodule FizzbuzzWeb.ApiPageView do
  use FizzbuzzWeb, :view

  def render("index.json", %{
        fizzbuzzed_values: values,
        favorites: favorites,
        pagination: pagination
      }) do
    %{
      fizzbuzzed_values: values,
      favorites: favorites,
      pagination: pagination
    }
  end
end
