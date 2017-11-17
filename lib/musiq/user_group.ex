defmodule Musiq.UserGroup do
  use Ecto.Schema
  alias Musiq.UserGroup
  import Ecto.Changeset

  schema "user_group" do
    belongs_to :user, Musiq.Accounts.User
    belongs_to :group, Musiq.Music.Group
    timestamps()
  end

  @doc false
  def changeset(%UserGroup{} = usergroup, params \\ %{}) do
    usergroup
    |> cast(params, [:user_id, :group_id])
    |> validate_required([:user_id, :group_id])
  end

end
