defmodule FizzbuzzWeb.ApiFavoriteControllerTest do
  use FizzbuzzWeb.ConnCase

  import Fizzbuzz.FavoritesFixtures

  @create_attrs %{
    number: 205_232
  }
  @invalid_attrs %{number: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all favorites", %{conn: conn} do
      conn = get(conn, Routes.api_favorite_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create favorite" do
    test "renders favorite when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_favorite_path(conn, :create), favorite: @create_attrs)

      assert %{"id" => _id} = json_response(conn, 201)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_favorite_path(conn, :create), favorite: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete favorite" do
    setup [:create_favorite]

    test "deletes chosen favorite", %{conn: conn, favorite: favorite} do
      conn = delete(conn, Routes.api_favorite_path(conn, :delete, favorite.number))
      assert response(conn, 204)
    end
  end

  defp create_favorite(_) do
    favorite = favorite_fixture()
    %{favorite: favorite}
  end
end
