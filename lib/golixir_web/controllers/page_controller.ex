defmodule GolixirWeb.PageController do
  use GolixirWeb, :controller
  alias Golixir.{Link}

  def index(conn, _params) do
    links = Link.find_all()
    render(conn, "links.html", links: links)
  end

  def show(conn, %{"name" => name}) do
    conn
    |> assign(:not_found, name)
    |> link_redirect(name, Link.find(name))
  end

  def create(conn, %{"name" => name, "uri" => uri, "description" => description}) do
    case Link.create(name, uri, description) do
      {:ok, _} -> redirect(conn, to: "/")
      {_, message} -> redirect(conn, to: "/?error=#{message}")
    end
  end

  def link_redirect(conn, name, nil), do: redirect(conn, to: "/?not_found=#{name}")

  def link_redirect(conn, _name, link) do
    Link.hit!(link)
    redirect(conn, external: link.uri)
  end
end
