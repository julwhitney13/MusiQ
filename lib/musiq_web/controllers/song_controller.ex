defmodule MusiqWeb.SongController do
  use MusiqWeb, :controller

  alias Musiq.Music
  alias Musiq.Music.Song

  action_fallback MusiqWeb.FallbackController

  def search(conn, params) do
    songs = Spotify.Search.query(conn, params)
    songs
  end

  def play(conn, params) do
    body = %{}
    x= %{uris: ["spotify:album:1Je1IMUlBXcx1Fz0WE7oPT"]}
    Spotify.Player.play(conn, x)
    send_resp(conn, :no_content, "")
  end

  def pause(conn, params) do
    Spotify.Player.pause(conn, params)
    send_resp(conn, :no_content, "")
  end

end
