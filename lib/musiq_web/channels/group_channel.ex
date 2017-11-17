defmodule MusiqWeb.GroupChannel do
  use MusiqWeb, :channel
  alias Musiq.Music.Queue

  def join("group:" <> groupID, payload, socket) do
    queue = Queue.get(groupID)
    {:ok, queue, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (group:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
