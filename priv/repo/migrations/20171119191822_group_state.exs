defmodule Musiq.Repo.Migrations.GroupState do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      add :state, :boolean, default: false
    end
  end
end
