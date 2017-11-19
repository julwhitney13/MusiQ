require IEx
defmodule MusiqWeb.SongController do
  use MusiqWeb, :controller
  alias Musiq.Music
  alias Musiq.Music.Song

  action_fallback MusiqWeb.FallbackController

  def search(conn, params) do
    {:ok, %{items: items}} = Spotify.Search.query(conn, List.first(params["_json"]))
    x = Poison.encode!(items) |> Poison.decode!
    json conn, x
  end

  def first(conn, params) do
    group_id = get_ID_from_conn(conn)
    group = Musiq.Music.get_group!(group_id)
    songs = Musiq.Music.get_songs_by_group_id(group_id)
    params = %{uris: songs}
    Spotify.Player.play(conn, params)
    if not group.state do
      Spotify.Player.pause(conn, params)
    end
    time = NaiveDateTime.diff(NaiveDateTime.utc_now, group.updated_at, :millisecond) + group.current_ms
    Spotify.Player.seek(conn, %{position_ms: time})
    send_resp(conn, :no_content, "")
  end

  def play(conn, params) do
    group_id = get_ID_from_conn(conn)
    update_time(conn, group_id)
    songs = Musiq.Music.get_songs_by_group_id(group_id)
    params = %{uris: songs}
    Spotify.Player.play(conn, params)
    send_resp(conn, :no_content, "")
  end

  def pause(conn, params) do
    group_id = get_ID_from_conn(conn)
    update_time(conn, group_id)
    Spotify.Player.pause(conn, params)
    IEx.pry
    send_resp(conn, :no_content, "")
  end

  def update_time(conn, groupID) do
    {:ok, info} = Spotify.Player.info(conn, %{})
    group = Musiq.Music.get_group!(groupID)
    change = Ecto.Changeset.change group, current_ms: info["progress_ms"]
    Musiq.Repo.update! change
  end

  def next(conn, params) do
    Spotify.Player.next(conn, %{})
    send_resp(conn, :no_content, "")
  end




end
