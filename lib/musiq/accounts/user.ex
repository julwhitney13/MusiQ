defmodule Musiq.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Musiq.Accounts.User


  schema "users" do
    field :admin?, :boolean, default: false
    field :email, :string
    field :spotify_id, :string
    field :username, :string
    has_many :created_groups, Musiq.Music.Group, foreign_key: :creator_id
    many_to_many :following_groups, Musiq.Music.Group, join_through: Musiq.UserGroup

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:spotify_id, :username, :email, :admin?])
    |> validate_required([:spotify_id, :username])
  end
end
