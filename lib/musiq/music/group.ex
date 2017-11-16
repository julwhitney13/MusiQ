defmodule Musiq.Music.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias Musiq.Music.Group


  schema "groups" do
    field :description, :string
    field :group_id, :integer
    field :name, :string
    belongs_to :creator, Musiq.Accounts.User, foreign_key: :creator_id
    has_many :listeners, Musiq.Accounts.User, foreign_key: :listener_id
    has_many :songs, Musiq.Music.Song

    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name, :group_id, :description, :creator_id])
    |> validate_required([:name, :group_id, :description])
  end
end
