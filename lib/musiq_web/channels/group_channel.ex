require IEx
defmodule MusiqWeb.GroupChannel do
  use MusiqWeb, :channel
  alias Musiq.Music.Queue

  def join("group:" <> groupID, payload, socket) do
    queue = Queue.get(groupID)
    socket = socket
    |> assign(:groupID, groupID)
    state = create_state(queue)
    {:ok, state, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("cards", payload, socket) do
    groupID = socket.assigns[:groupID]
    Queue.update(groupID, payload)
    broadcast socket, "newQueue", payload
    {:reply, {:ok, %{}}, socket}
  end

  def handle_in("play", payload, socket) do
    groupID = socket.assigns[:groupID]
    Queue.update_state(groupID, true)
    broadcast socket, "play", %{}
    {:reply, {:ok, %{}}, socket}
  end

  def handle_in("pause", payload, socket) do
    groupID = socket.assigns[:groupID]
    Queue.update_state(groupID, false)

    broadcast socket, "pause", %{}
    {:reply, {:ok, %{}}, socket}
  end

  def handle_in("next", payload, socket) do
    groupID = socket.assigns[:groupID]
    broadcast socket, "next", %{}
    {:reply, {:ok, %{}}, socket}
  end

  def create_state(songs) do
    %{cards: Enum.map(songs, fn(x) ->
      info = %{
      id: x.spotify_id,
      title: x.title,
      artist: x.artist
    }
    info
    end)}


  end

end
