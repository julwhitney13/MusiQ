require IEx
defmodule MusiqWeb.SongController do
  use MusiqWeb, :controller
  import Ecto.Query, only: [from: 2]
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
    query = from s in Musiq.Music.Song,
            where: s.group_id == ^group_id,
            select: s.spotify_id
    songs = Musiq.Repo.all(query)
    params = %{uris: songs}
    Spotify.Player.shuffle(conn, %{state: false})
    IEx.pry
    if group.state do
      Spotify.Player.play(conn, params)
      time = NaiveDateTime.diff(NaiveDateTime.utc_now, group.updated_at, :millisecond) + group.current_ms

      Spotify.Player.seek(conn, %{position_ms: time})

    else
      Spotify.Player.pause(conn, params)
    end
    send_resp(conn, :no_content, "")
  end

  def play(conn, params) do
    group_id = get_ID_from_conn(conn)
    update_time(conn, group_id)
    query = from s in Musiq.Music.Song,
            where: s.group_id == ^group_id,
            select: s.spotify_id
    songs = Musiq.Repo.all(query)
    params = %{uris: songs}
    params = Map.put(params, :offset, %{position: 0})
    IEx.pry
    Spotify.Player.play(conn, params)
    send_resp(conn, :no_content, "")
  end

  def pause(conn, params) do
    group_id = get_ID_from_conn(conn)
    update_time(conn, group_id)
    Spotify.Player.pause(conn, params)
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
