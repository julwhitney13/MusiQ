defmodule Musiq.Repo.Migrations.GroupSongTime do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      add :current_ms, :integer
    end

  end
end
