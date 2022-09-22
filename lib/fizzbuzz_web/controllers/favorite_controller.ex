defmodule FizzbuzzWeb.FavoriteController do
  use FizzbuzzWeb, :controller

  alias Fizzbuzz.Favorites
  alias Fizzbuzz.Favorites.Favorite

  action_fallback FizzbuzzWeb.FallbackController

  def create(conn, %{
        "favorite_number" => raw_favorite_number,
        "page" => raw_page,
        "page_size" => raw_page_size
      }) do
    with {:ok, %Favorite{} = _favorite} <-
           Favorites.create_favorite(%{number: raw_favorite_number}) do
      conn
      |> put_flash(:created_favorite, "Favored this number !")
      |> redirect(
        to:
          Routes.page_path(conn, :index,
            page: raw_page,
            page_size: raw_page_size
          )
      )
    end
  end

  # Ideally this should be a delete call, but for simplicity's sake we used a POST with unfavorite as param
  def create(conn, %{
        "unfavorite_number" => raw_favorite_number,
        "page" => raw_page,
        "page_size" => raw_page_size
      }) do
    with {number, _} <- Integer.parse(raw_favorite_number),
         %Favorite{} = favorite <- Favorites.get_favorite!(number),
         {:ok, %Favorite{}} <- Favorites.delete_favorite(favorite) do
      conn
      |> put_flash(:created_favorite, "Unfavored this number !")
      |> redirect(
        to:
          Routes.page_path(conn, :index,
            page: raw_page,
            page_size: raw_page_size
          )
      )
    end
  end
end
