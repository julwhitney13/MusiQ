defmodule Musiq.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Musiq.Accounts.User


  schema "users" do
    field :admin?, :boolean, default: false
    field :email, :string
    field :spotify_id, :integer
    field :username, :string
    has_many :created_groups, Musiq.Music.Group, foreign_key: :created_id
    has_many :following_groups, Musiq.Music.Group, foreign_key: :following_id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:spotify_id, :username, :email, :admin?])
    |> validate_required([:spotify_id, :username, :email, :admin?])
  end
end
