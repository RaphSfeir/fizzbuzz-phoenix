defmodule FizzbuzzWeb.ApiFavoriteView do
  use FizzbuzzWeb, :view
  alias FizzbuzzWeb.ApiFavoriteView

  def render("index.json", %{favorites: favorites}) do
    %{data: render_many(favorites, ApiFavoriteView, "favorite.json")}
  end

  def render("show.json", %{favorite: favorite}) do
    %{data: render_one(favorite, ApiFavoriteView, "favorite.json")}
  end

  def render("favorite.json", %{api_favorite: favorite}) do
    %{
      id: favorite.id,
      number: favorite.number
    }
  end
end
