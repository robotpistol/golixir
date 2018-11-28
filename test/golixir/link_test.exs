defmodule Golixir.LinkTest do
  use Golixir.DataCase

  alias Golixir.{Link}

  @name "brex"
  @uri "https://www.brex.com"
  @description "hi brex!"

  test "search" do
    link = Link.create(@name, @uri, @description)
    link2 = Link.create("allen", @uri, "look it's brex!")
    link3 = Link.create("a", @uri, "description")
    Link.create("b", "https://www.google.com", "description")

    assert Link.search("bre") == [link, link2, link3]
  end

  test "find_all" do
    link = Link.create(@name, @uri, @description)
    link2 = Link.create("allen", @uri, "look it's brex!")
    link3 = Link.create("a", @uri, "description")
    link4 = Link.create("b", "https://www.google.com", "description")

    assert Link.find_all() == [link, link2, link3, link4]
  end

  test "find" do
    link = Link.create(@name, @uri, @description)
    assert Link.find(@name) == link
  end

  test "find when link does not exist" do
    assert Link.find(@name) == nil
  end

  test "to_map" do
    link = Link.create(@name, @uri, @description)
    assert Link.to_map(link) == %{name: @name, uri: @uri, hits: 0, description: @description}
  end
end
