defmodule MusiqWeb.GroupChannel do
  use MusiqWeb, :channel
  alias Musiq.Music.Queue

  def join("group:" <> groupID, payload, socket) do
    queue = Queue.get(groupID)
    socket = socket
    |> assign(:groupID, groupID)
    {:ok, queue, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("cards", payload, socket) do
    groupID = socket.assigns[:groupID]
    Queue.update(groupID, payload)
    broadcast socket, "newQueue", payload
    {:noreply, socket}
  end
  
end
