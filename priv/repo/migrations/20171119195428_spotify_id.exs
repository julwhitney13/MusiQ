defmodule Musiq.Repo.Migrations.SpotifyId do
  use Ecto.Migration

  def change do
    alter table(:songs) do
      modify :spotify_id, :string
    end
  end
end
