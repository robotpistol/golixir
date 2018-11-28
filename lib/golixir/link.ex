defmodule Golixir.Link do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Golixir.{Link}
  alias Golixir.{Repo}

  schema "links" do
    field :name, :string, unique: true
    field :uri, :string
    field :description, :string
    field :hits, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:name, :uri, :hits, :description])
    |> validate_required([:name, :uri, :hits, :description])
    |> update_change(:name, &String.trim/1) 
    |> update_change(:uri, &String.trim/1) 
    |> update_change(:description, &String.trim/1) 
    |> unique_constraint(:name)
    |> validate_format(:uri, ~r{^(https|http)://})
  end

  def search(q) do
    Link
    |> Ecto.Queryable.to_query()
    |> where([l], ilike(l.name, ^"%#{q}%"))
    |> or_where([l], ilike(l.description, ^"%#{q}%"))
    |> or_where([l], ilike(l.uri, ^"%#{q}%"))
    |> order_by([l], l.hits)
    |> Repo.all()
  end

  def find_all do
    Link
    |> order_by([l], l.hits)
    |> Repo.all()
  end

  def find(name) do
    Repo.get_by(Link, name: name)
  end

  def create(name, uri, description) do
    %Link{}
    |> changeset(%{name: name, uri: uri, description: description})
    |> Repo.insert()
  end

  def create!(name, uri, description) do
    %Link{}
    |> changeset(%{name: name, uri: uri, description: description})
    |> Repo.insert!()
  end

  def update(original, changeset) do
    Repo.all(original, changeset)
  end

  def hit!(link) do
    link
    |> changeset(%{hits: link.hits + 1})
    |> Repo.update()
  end

  def to_map(link) do
    %{
      name: link.name,
      uri: link.uri,
      description: link.description,
      hits: link.hits
    }
  end
end

# Golixir.Link.create("brex", "https://brex.com", "it's brex!")
