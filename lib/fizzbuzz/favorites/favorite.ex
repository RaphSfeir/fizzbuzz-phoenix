defmodule Fizzbuzz.Favorites.Favorite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorites" do
    field :number, :integer

    timestamps()
  end

  @doc false
  def changeset(favorite, attrs) do
    favorite
    |> cast(attrs, [:number])
    |> validate_required([:number])
    |> unique_constraint(:number)
  end
end
