defmodule Musiq.Repo.Migrations.AddUserGrgroupJoinTable do
  use Ecto.Migration

  def change do
    create table(:user_group) do
      add :user_id, references(:users)
      add :group_id, references(:groups)
      timestamps()
    end
  end
end
