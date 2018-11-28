defmodule Golixir.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :name, :string
      add :uri, :string
      add :hits, :integer
      add :description, :text

      timestamps()
    end

    create unique_index(:links, [:name])
  end
end
