defmodule GolixirWeb.PageControllerTest do
  use GolixirWeb.ConnCase
  alias GolixirWeb.PageController, as: PC

  alias Golixir.Data.Link

  @name "google"
  @uri "https://www.google.com"
  @description "Google!"

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end

  test "POST /", %{conn: conn} do
    post(conn, "/", %{
      "name" => @name,
      "uri" => @uri,
      "description" => @description
    })

    assert Link.find(@name)
  end

  test "show /:name", %{conn: conn} do
    Link.create!(@name, @uri, @description)

    conn = get(conn, "/#{@name}")
    assert redirected_to(conn) =~ @uri
  end

  test "show /:name with interpolation", %{conn: conn} do
      Link.create!("gif", "https://www.google.com/search?tbm=isch&tbs=itp:animated&q={{}}", "Gif Search")

    conn = get(conn, "/gif/dogs")
    assert redirected_to(conn) =~ "https://www.google.com/search?tbm=isch&tbs=itp:animated&q=dogs"
  end

  test "name_params/1" do
    assert PC.name_params(["a","b","c"]) == [
      {"a/b/c", []},
      {"a/b", ["c"]},
      {"a", ["b", "c"]},
    ]
  end

  test "link_interpolation/1" do
    link = Link.create!("gif", "https://www.google.com/search?tbm=isch&tbs=itp:animated&q={{}}", "Gif Search")

    assert PC.link_interpolate(link, ["dogs"]) == "https://www.google.com/search?tbm=isch&tbs=itp:animated&q=dogs"
  end

  test "link_interpolation with no args/1" do
    link = Link.create!("dogs", "https://www.google.com/search?tbm=isch&tbs=itp:animated&q=dogs", "Gif Search")

    assert PC.link_interpolate(link, []) == "https://www.google.com/search?tbm=isch&tbs=itp:animated&q=dogs"
  end
end
