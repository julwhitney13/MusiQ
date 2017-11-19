defmodule Musiq.Music.Song do
  use Ecto.Schema
  import Ecto.Changeset
  alias Musiq.Music.Song


  schema "songs" do
    field :song_order, :integer
    field :spotify_id, :string
    field :title, :string
    field :artist, :string
    belongs_to :group, Musiq.Music.Group

    timestamps()
  end

  @doc false
  def changeset(%Song{} = song, attrs) do
    song
    |> cast(attrs, [:spotify_id, :song_order, :group_id, :title, :artist])
    |> validate_required([:spotify_id, :song_order, :title, :artist])
  end
end
