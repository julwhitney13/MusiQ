defmodule MusiqWeb.SongController do
  use MusiqWeb, :controller

  alias Musiq.Music
  alias Musiq.Music.Song

  action_fallback MusiqWeb.FallbackController

  def search(conn, params) do
    songs = Spotify.Search.query(conn, params)
    songs
  end

  def search(conn, params) do
    Spotify.Player.play(conn, params)
    conn
    |> put_flash(:info, "Music Played")
    |> send_resp(:no_content, "")
  end

  def search(conn, params) do
    Spotify.Player.pause(conn, params)
    conn
    |> put_flash(:info, "Music Played")
    |> send_resp(:no_content, "")
  end

end
