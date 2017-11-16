defmodule MusiqWeb.AuthorizationController do
  use MusiqWeb, :controller

  def authorize(conn, params) do
    redirect conn, external: Spotify.Authorization.url
  end

end
