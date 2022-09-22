defmodule Fizzbuzz.Repo.Migrations.CreateFavorites do
  use Ecto.Migration

  def change do
    create table(:favorites) do
      add :number, :integer

      timestamps()
    end

    create unique_index(:favorites, [:number])
  end
end
