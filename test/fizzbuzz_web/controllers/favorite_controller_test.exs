defmodule FizzbuzzWeb.FavoriteControllerTest do
  use FizzbuzzWeb.ConnCase

  import Fizzbuzz.FavoritesFixtures
  alias Fizzbuzz.Favorites
  alias Fizzbuzz.Favorites.Favorite

  @create_attrs %{
    number: 205_232
  }
  @invalid_attrs %{number: -24.3}

  describe "create favorite" do
    test "created favorite and redirects to root when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.favorite_path(conn, :create),
          favorite_number: @create_attrs.number,
          page: 1,
          page_size: 25
        )

      assert "/?page=1&page_size=25" = redir_path = redirected_to(conn, 302)
      assert %Favorite{} = Favorites.get_favorite!(@create_attrs.number)
      conn = get(recycle(conn), redir_path)
      assert html_response(conn, 200) =~ "Welcome to FizzBuzz!"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.favorite_path(conn, :create),
          favorite_number: @invalid_attrs.number,
          page: 1,
          page_size: 25
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete favorite using POST request" do
    setup [:create_favorite]

    test "delete favorite and redirects to root when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.favorite_path(conn, :create), %{
          # We use string keys this case to simulate actual call and not raise parsing error
          "unfavorite_number" => "42",
          "page" => "1",
          "page_size" => "25"
        })

      assert "/?page=1&page_size=25" = redir_path = redirected_to(conn, 302)
      conn = get(recycle(conn), redir_path)
      assert html_response(conn, 200) =~ "Welcome to FizzBuzz!"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.favorite_path(conn, :create),
          favorite_number: @invalid_attrs.number,
          page: 1,
          page_size: 25
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_favorite(_) do
    favorite = favorite_fixture()
    %{favorite: favorite}
  end
end
