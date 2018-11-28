defmodule GolixirWeb.LinkControllerTest do
  alias Golixir.{Link}
  use GolixirWeb.ConnCase

  @name "brex"
  @uri "https://www.brex.com"
  @description "hi"

  test "GET /links", %{conn: conn} do
    conn = get(conn, "/links")
    assert json_response(conn, 200) == %{"links" => []}
  end

  test "POST /links", %{conn: conn} do
    conn =
      post(conn, "/links", %{
        "name" => @name,
        "uri" => @uri,
        "description" => @description
      })

    assert json_response(conn, 200) == %{
             "link" => %{
               "name" => @name,
               "uri" => @uri,
               "description" => @description,
               "hits" => 0
             }
           }
  end

  test "SHOW /links/brex", %{conn: conn} do
    Link.create(@name, @uri, @description)

    conn = get(conn, "/links/brex")

    assert json_response(conn, 200) == %{
             "link" => %{
               "name" => @name,
               "uri" => @uri,
               "description" => @description,
               "hits" => 0
             }
           }
  end
end
