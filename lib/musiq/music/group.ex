defmodule Musiq.Music.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias Musiq.Music.Group


  schema "groups" do
    field :description, :string
    field :name, :string
    belongs_to :creator, Musiq.Accounts.User, foreign_key: :creator_id
    many_to_many :listener, Musiq.Accounts.User, join_through: Musiq.UserGroup
    has_many :songs, Musiq.Music.Song

    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name, :description, :creator_id])
    |> validate_required([:name, :description])
  end
end
