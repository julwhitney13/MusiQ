defmodule Musiq.Music.Queue do
  alias Musiq.Repo

  def get(groupID) do
    group = get_group!(groupID)
    songs = Repo.preload group, [songs: from(s in Song, order_by: s.order)]
    songs
  end

  def update(groupID, data) do
    group = get_group!(groupID)
    Repo.Preload group, [songs:] |> Repo.delete_all
  end

end
