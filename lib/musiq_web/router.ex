defmodule MusiqWeb.Router do
  use MusiqWeb, :router
  import MusiqWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MusiqWeb do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController, except: [:delete]
    resources "/groups", GroupController
    get "/", AuthorizationController, :authorize
    get "/authenticate", AuthenticationController, :authenticate
    delete "/authentication", AuthenticationController, :logout
  end

  scope "/api/v1", MusiqWeb do
    pipe_through :api
    post "/search", SongController, :search
    get "/play", SongController, :play
    get "/pause", SongController, :pause
  end
  # Other scopes may use custom stacks.
  # scope "/api", MusiqWeb do
  #   pipe_through :api
  # end
end
