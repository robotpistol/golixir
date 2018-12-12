defmodule GolixirWeb.Router do
  use GolixirWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/links", GolixirWeb do
    resources "/", LinkController, only: [:index, :show, :create]
  end

  scope "/", GolixirWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/", PageController, :create
    get "/*name", PageController, :show
  end
end
