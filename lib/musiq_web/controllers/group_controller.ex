require IEx
defmodule MusiqWeb.GroupController do
  use MusiqWeb, :controller

  alias Musiq.Music
  alias Musiq.Music.Group

  def index(conn, _params) do
    groups = Music.list_groups()
    render(conn, "index.html", groups: groups)
  end

  def new(conn, _params) do
    changeset = Music.change_group(%Group{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"group" => group_params}) do
    id = get_session(conn, :user_id)
    group_params = Map.put(group_params, "creator_id", id)
    case Music.create_group(group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group created successfully.")
        |> redirect(to: group_path(conn, :show, group))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Music.get_group!(id)
    group = Musiq.Repo.preload(group, :listener)
    user_id = get_session(conn, :user_id)
    if Enum.all?(group.listener, fn(x) -> x.id != user_id end) do
      Musiq.Accounts.associate_group(user_id, id)
    end

    conn
    |> assign(:group_id, id)
    |> render("show.html", group: group)
  end

  def edit(conn, %{"id" => id}) do
    group = Music.get_group!(id)
    changeset = Music.change_group(group)
    render(conn, "edit.html", group: group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Music.get_group!(id)

    case Music.update_group(group, group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group updated successfully.")
        |> redirect(to: group_path(conn, :show, group))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", group: group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Music.get_group!(id)
    {:ok, _group} = Music.delete_group(group)

    conn
    |> put_flash(:info, "Group deleted successfully.")
    |> redirect(to: group_path(conn, :index))
  end
end
