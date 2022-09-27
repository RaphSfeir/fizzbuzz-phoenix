defmodule Fizzbuzz.Favorites do
  @moduledoc """
  The Favorites context.
  """

  import Ecto.Query, warn: false
  alias Fizzbuzz.Repo

  alias Fizzbuzz.Favorites.Favorite

  @doc """
  Returns the list of favorites.

  ## Examples

      iex> list_favorites()
      [%Favorite{}, ...]

  """
  def list_favorites do
    Repo.all(Favorite)
  end

  @doc """
  Returns the list of favorites in a specific range of numbers.

  ## Examples

      iex> list_favorites(0, 1000)
      [%Favorite{}, ...]

  """
  def list_favorites_in_range(min, max),
    do:
      Repo.all(
        from f in "favorites",
          where: f.number >= type(^min, :integer) and f.number <= type(^max, :integer),
          select: %Favorite{
            id: f.id,
            number: f.number,
            inserted_at: f.inserted_at,
            updated_at: f.updated_at
          }
      )

  @doc """
  Gets a single favorite.

  Raises `Ecto.NoResultsError` if the Favorite does not exist.

  ## Examples

      iex> get_favorite!(123)
      %Favorite{}

      iex> get_favorite!(456)
      ** (Ecto.NoResultsError)

  """
  def get_favorite!(number), do: Repo.get_by!(Favorite, number: number)

  @doc """
  Creates a favorite.

  ## Examples

      iex> create_favorite(%{field: value})
      {:ok, %Favorite{}}

      iex> create_favorite(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_favorite(attrs \\ %{}) do
    %Favorite{}
    |> Favorite.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a favorite.

  ## Examples

      iex> delete_favorite(favorite)
      {:ok, %Favorite{}}

      iex> delete_favorite(favorite)
      {:error, %Ecto.Changeset{}}

  """
  def delete_favorite(%Favorite{} = favorite) do
    Repo.delete(favorite)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking favorite changes.

  ## Examples

      iex> change_favorite(favorite)
      %Ecto.Changeset{data: %Favorite{}}

  """
  def change_favorite(%Favorite{} = favorite, attrs \\ %{}) do
    Favorite.changeset(favorite, attrs)
  end
end
