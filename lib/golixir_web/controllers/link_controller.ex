defmodule GolixirWeb.LinkController do
  use GolixirWeb, :controller
  alias Golixir.{Link}

  def index(conn, _params) do
    links = Link.find_all()
    render(conn, "index.json", links: links)
  end

  def create(conn, %{"name" => name, "uri" => uri, "description" => description}) do
    new_link = Link.create(name, uri, description)
    render(conn, "show.json", link: new_link)
  end

  def show(conn, %{"id" => name}) do
    link = Link.find(name)
    render(conn, "show.json", link: link)
  end

  def search(conn, %{"q" => q}) do
    links = Link.search(q)
    render(conn, "index.json", links: links)
  end
end
