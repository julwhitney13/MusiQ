require IEx
defmodule MusiqWeb.Plugs do
  import Plug.Conn

  def fetch_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = Musiq.Accounts.get_user(user_id)
      if user do
        assign(conn, :current_user, user)
      else
        assign(conn, :current_user, nil)
      end
    else
      assign(conn, :current_user, nil)
    end

  end

  def auth?(conn, _opts) do
    case Spotify.Authentication.refresh(conn) do
      {:ok, conn} -> conn
      {:error, reason} -> Phoenix.Controller.redirect conn, external: Spotify.Authorization.url
    end
  end

end
