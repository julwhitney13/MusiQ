defmodule Musiq.Repo.Migrations.ModifySong do
  use Ecto.Migration

  def change do
    alter table(:songs) do
      add :title, :string
      add :artist, :string
    end
  end
end
