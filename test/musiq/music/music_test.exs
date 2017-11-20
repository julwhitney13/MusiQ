defmodule Musiq.MusicTest do
  use Musiq.DataCase

  alias Musiq.Music

  describe "groups" do
    alias Musiq.Music.Group

    @valid_attrs %{description: "some description", group_id: 42, name: "some name"}
    @update_attrs %{description: "some updated description", group_id: 43, name: "some updated name"}
    @invalid_attrs %{description: nil, group_id: nil, name: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Music.create_group()

      group
    end

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Music.list_groups() == [group]
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Music.create_group(@valid_attrs)
      assert group.description == "some description"
      assert group.group_id == 42
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Music.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      assert {:ok, group} = Music.update_group(group, @update_attrs)
      assert %Group{} = group
      assert group.description == "some updated description"
      assert group.group_id == 43
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Music.update_group(group, @invalid_attrs)
      assert group == Music.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Music.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Music.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Music.change_group(group)
    end
  end

  describe "songs" do
    alias Musiq.Music.Song

    @valid_attrs %{order: 42, spotify_id: 42}
    @update_attrs %{order: 43, spotify_id: 43}
    @invalid_attrs %{order: nil, spotify_id: nil}

    def song_fixture(attrs \\ %{}) do
      {:ok, song} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Music.create_song()

      song
    end

    test "list_songs/0 returns all songs" do
      song = song_fixture()
      assert Music.list_songs() == [song]
    end

    test "get_song!/1 returns the song with given id" do
      song = song_fixture()
      assert Music.get_song!(song.id) == song
    end

    test "create_song/1 with valid data creates a song" do
      assert {:ok, %Song{} = song} = Music.create_song(@valid_attrs)
      assert song.order == 42
      assert song.spotify_id == 42
    end

    test "create_song/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Music.create_song(@invalid_attrs)
    end

    test "update_song/2 with valid data updates the song" do
      song = song_fixture()
      assert {:ok, song} = Music.update_song(song, @update_attrs)
      assert %Song{} = song
      assert song.order == 43
      assert song.spotify_id == 43
    end

    test "update_song/2 with invalid data returns error changeset" do
      song = song_fixture()
      assert {:error, %Ecto.Changeset{}} = Music.update_song(song, @invalid_attrs)
      assert song == Music.get_song!(song.id)
    end

    test "delete_song/1 deletes the song" do
      song = song_fixture()
      assert {:ok, %Song{}} = Music.delete_song(song)
      assert_raise Ecto.NoResultsError, fn -> Music.get_song!(song.id) end
    end

    test "change_song/1 returns a song changeset" do
      song = song_fixture()
      assert %Ecto.Changeset{} = Music.change_song(song)
    end
  end
end
