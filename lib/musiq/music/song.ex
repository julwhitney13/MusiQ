defmodule Musiq.Music.Song do
  use Ecto.Schema
  import Ecto.Changeset
  alias Musiq.Music.Song


  schema "songs" do
    field :order, :integer
    field :spotify_id, :integer
    belongs_to :group, Musiq.Music.Group

    timestamps()
  end

  @doc false
  def changeset(%Song{} = song, attrs) do
    song
    |> cast(attrs, [:spotify_id, :order, :group_id])
    |> validate_required([:spotify_id, :order])
  end
end
