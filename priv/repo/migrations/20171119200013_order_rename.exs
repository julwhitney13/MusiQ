defmodule Musiq.Repo.Migrations.OrderRename do
  use Ecto.Migration

  def change do
    rename table("songs"), :order, to: :song_order
  end
end
