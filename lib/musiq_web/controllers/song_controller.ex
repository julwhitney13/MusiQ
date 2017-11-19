require IEx
defmodule MusiqWeb.SongController do
  use MusiqWeb, :controller

  alias Musiq.Music
  alias Musiq.Music.Song

  action_fallback MusiqWeb.FallbackController

  def search(conn, params) do
    {:ok, %{items: items}} = Spotify.Search.query(conn, List.first(params["_json"]))
    IEx.pry
    x = Poison.encode!(items) |> Poison.decode!
    json conn, x
  end

  def play(conn, params) do
    body = %{}
    x= %{uris: ["spotify:track:4iV5W9uYEdYUVa79Axb7Rh", "spotify:track:1301WleyT98MSxVHPZCA6M"]}
    Spotify.Player.play(conn, x)
    send_resp(conn, :no_content, "")
  end

  def pause(conn, params) do
    Spotify.Player.pause(conn, params)
    send_resp(conn, :no_content, "")
  end

  def next(conn, params) do
    Spotify.Player.seek(conn, %{position_ms: "0"})
    send_resp(conn, :no_content, "")
  end

  def info(conn, params) do
    i = Spotify.Player.info(conn, params)
    IEx.pry
  end



end
