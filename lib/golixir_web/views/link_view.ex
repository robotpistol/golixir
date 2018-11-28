defmodule GolixirWeb.LinkView do
  use GolixirWeb, :view
  alias Golixir.{Link}

  def render("link.json", %{link: link}) do
    Link.to_map(link)
  end

  def render("index.json", %{links: links}) do
    %{links: render_many(links, GolixirWeb.LinkView, "link.json")}
  end

  def render("show.json", %{link: link}) do
    %{link: render_one(link, GolixirWeb.LinkView, "link.json")}
  end
end
