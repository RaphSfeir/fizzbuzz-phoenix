defmodule FizzbuzzWeb.ApiFavoriteController do
  use FizzbuzzWeb, :controller

  alias Fizzbuzz.Favorites
  alias Fizzbuzz.Favorites.Favorite

  action_fallback FizzbuzzWeb.FallbackController

  def index(conn, _params) do
    favorites = Favorites.list_favorites()
    render(conn, "index.json", favorites: favorites)
  end

  def create(conn, %{
        "favorite" => favorite_params
      }) do
    with {:ok, %Favorite{} = favorite} <-
           Favorites.create_favorite(favorite_params) do
      conn
      |> put_status(:created)
      |> render("favorite.json", api_favorite: favorite)
    end
  end

  def delete(conn, %{
        "id" => raw_favorite_number
      }) do
    {number, _} = Integer.parse(raw_favorite_number)
    favorite = Favorites.get_favorite!(number)

    with {:ok, %Favorite{}} <- Favorites.delete_favorite(favorite) do
      conn
      |> send_resp(:no_content, "")
    end
  end
end
