defmodule Musiq.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :spotify_id, :integer
      add :order, :integer
      add :group_id, references(:groups, on_delete: :nothing)

      timestamps()
    end

    alter table("groups") do
      add :song_id, references(:songs, on_delete: :nothing)
    end

    create index(:songs, [:group_id])
  end
end
