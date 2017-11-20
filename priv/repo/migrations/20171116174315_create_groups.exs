defmodule Musiq.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :description, :text
      add :creator_id, references(:users, on_delete: :nothing)
      add :listener_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    alter table("users") do
      add :created_id, references(:groups, on_delete: :delete_all)
      add :following_id, references(:groups)
    end

    create index(:groups, [:creator_id])
    create index(:groups, [:listener_id])
    create index(:users, [:created_id])
    create index(:users, [:following_id])
  end
end
