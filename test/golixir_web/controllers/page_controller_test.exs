defmodule GolixirWeb.PageControllerTest do
  use GolixirWeb.ConnCase

  alias Golixir.{Link}

  @name "brex"
  @uri "https://www.brex.com"
  @description "hi brex!"

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
end
