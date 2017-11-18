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

end
