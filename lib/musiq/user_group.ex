defmodule Musiq.UserGroup do
  use Ecto.Schema

  schema "user_group" do
    belongs_to :user, Musiq.Accounts.User
    belongs_to :group, Musiq.Music.Group
    timestamps()
  end
end
