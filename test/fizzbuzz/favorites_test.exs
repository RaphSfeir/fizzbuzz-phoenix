defmodule Fizzbuzz.FavoritesTest do
  use Fizzbuzz.DataCase

  alias Fizzbuzz.Favorites

  describe "favorites" do
    alias Fizzbuzz.Favorites.Favorite

    import Fizzbuzz.FavoritesFixtures

    @invalid_attrs %{number: nil}

    test "list_favorites/0 returns all favorites" do
      favorite = favorite_fixture()
      assert Favorites.list_favorites() == [favorite]
    end

    test "list_favorites_in_range/0 returns favorites within range" do
      favorite_find = favorite_fixture(%{number: 1})
      favorite_find2 = favorite_fixture(%{number: 25})
      _favorite_not_find = favorite_fixture(%{number: 26})
      assert Favorites.list_favorites_in_range(1, 25) == [favorite_find, favorite_find2]
    end

    test "list_favorites_in_range/0 returns nothing outside range" do
      favorite_fixture(%{number: 1})
      favorite_fixture(%{number: 100})
      assert Favorites.list_favorites_in_range(2, 99) == []
    end

    test "get_favorite!/1 returns the favorite with given id" do
      favorite = favorite_fixture()
      assert Favorites.get_favorite!(favorite.number) == favorite
    end

    test "create_favorite/1 with valid data creates a favorite" do
      valid_attrs = %{number: 42}

      assert {:ok, %Favorite{} = favorite} = Favorites.create_favorite(valid_attrs)
      assert favorite.number == 42
    end

    test "create_favorite/1 with same data raises constraint error" do
      valid_attrs = %{number: 42}

      assert {:ok, %Favorite{} = favorite} = Favorites.create_favorite(valid_attrs)
      assert {:error, %Ecto.Changeset{valid?: false}} = Favorites.create_favorite(valid_attrs)

      assert favorite.number == 42
    end

    test "create_favorite/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Favorites.create_favorite(@invalid_attrs)
    end

    test "delete_favorite/1 deletes the favorite" do
      favorite = favorite_fixture()
      assert {:ok, %Favorite{}} = Favorites.delete_favorite(favorite)
      assert_raise Ecto.NoResultsError, fn -> Favorites.get_favorite!(favorite.number) end
    end

    test "change_favorite/1 returns a favorite changeset" do
      favorite = favorite_fixture()
      assert %Ecto.Changeset{} = Favorites.change_favorite(favorite)
    end
  end
end
