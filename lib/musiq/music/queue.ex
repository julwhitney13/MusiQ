require IEx
defmodule Musiq.Music.Queue do
  alias Musiq.Repo
  import Ecto.Query, only: [from: 2]

  def get(groupID) do
    group = Musiq.Music.get_group!(groupID)
    |>
    Repo.preload songs: from(s in Musiq.Music.Song, order_by: s.song_order)
    group.songs

  end

  def update(groupID, data) do
    group = Musiq.Music.get_group!(groupID)
    |> Repo.preload [:songs]
    Repo.delete_all(group.songs)
    Ecto.Changeset.change group, current_ms: 0
    Repo.update! group
    data
    |> Enum.with_index
    |> Enum.each(fn({song, index}) ->
      object = %{song_order: index, spotify_id: song.id,
      title: song.title, artist: song.artist, group_id: groupID}
      Musiq.Music.create_song(object)
    end)
  end

end
