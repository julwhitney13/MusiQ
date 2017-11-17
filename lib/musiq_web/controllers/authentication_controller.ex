require IEx
defmodule MusiqWeb.AuthenticationController do
  use MusiqWeb, :controller

  def authenticate(conn, params) do
    case Spotify.Authentication.authenticate(conn, params) do
      {:ok, conn} ->
        {:ok, profile} = Spotify.Profile.me(conn)
        user = Musiq.Accounts.get_or_create_user(profile)
        IEx.pry
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Logged in as #{user.username}")
        |> redirect(to: "/groups")
        {:error, reason, conn} ->
          redirect conn, to: "/authorize"
      end
  end

  def logout(conn, _args) do
    conn
    |> put_session(:user_id, nil)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

end
