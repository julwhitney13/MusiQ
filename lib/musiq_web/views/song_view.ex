defmodule MusiqWeb.SongView do
  use MusiqWeb, :view
  alias MusiqWeb.SongView

  def render("index.json", %{songs: songs}) do
    %{data: render_many(songs, SongView, "song.json")}
  end

  def render("show.json", %{song: song}) do
    %{data: render_one(song, SongView, "song.json")}
  end

  def render("song.json", %{song: song}) do
    %{id: song.id,
      spotify_id: song.spotify_id,
      order: song.order}
  end
end
