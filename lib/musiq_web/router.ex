defmodule MusiqWeb.Router do
  use MusiqWeb, :router

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

  scope "/", MusiqWeb do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController
    resources "/groups", GroupController
    get "/", PageController, :index
  end
  
  scope "/api/vi", MusiqWeb do
    pipe_through :api
    resources "/songs", SongController, except: [:new, :edit]
  end
  # Other scopes may use custom stacks.
  # scope "/api", MusiqWeb do
  #   pipe_through :api
  # end
end
