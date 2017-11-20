defmodule Musiq.Repo.Migrations.ChangeSpotifyfyIdType do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :spotify_id, :string
    end
  end
end
