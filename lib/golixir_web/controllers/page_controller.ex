defmodule GolixirWeb.PageController do
  use GolixirWeb, :controller
  alias Golixir.Data.Link

  def index(conn, _params) do
    links = Link.find_all()
    render(conn, "links.html", links: links)
  end

  def show(conn, %{"name" => components}) do
    find_link_in_db = fn {name, args} ->
      case Link.find(name) do
        nil -> nil
        link -> {link, args}
      end
    end

    with {link, args} <- name_params(components) |> Enum.find_value(find_link_in_db)
    do
      link_redirect(conn, link, args)
    else _  ->
      link_redirect_missing(conn, components |> Enum.join("/"))
    end
  end

  def name_params(components) do
    Enum.reduce(1..length(components), [], fn x, acc ->
      {left, right} = Enum.split(components, x)
      [{Enum.join(left, "/"), right} | acc]
    end)
  end

  def create(conn, %{"name" => name, "uri" => uri, "description" => description}) do
    case Link.create(name, uri, description) do
      {:ok, _} -> redirect(conn, to: "/")
      {_, message} -> redirect(conn, to: "/?error=#{message}")
    end
  end

  def link_redirect_missing(conn, name), do: redirect(conn, to: "/?not_found=#{name}")

  def link_redirect(conn, link, args) do
    Link.hit(link)
    redirect(conn, external: link_interpolate(link, args))
  end

  def link_interpolate(link, args) do
    Enum.reduce(args, link.uri, &(String.replace(&2, "{{}}", &1)))
  end
end
