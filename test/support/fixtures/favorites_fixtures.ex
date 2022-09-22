defmodule Fizzbuzz.FavoritesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fizzbuzz.Favorites` context.
  """

  @doc """
  Generate a favorite.
  """
  def favorite_fixture(attrs \\ %{}) do
    {:ok, favorite} =
      attrs
      |> Enum.into(%{
        number: 42
      })
      |> Fizzbuzz.Favorites.create_favorite()

    favorite
  end
end
