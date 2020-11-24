defmodule ChatterWeb.ChatRoomChannel do
  use ChatterWeb, :channel

  def join("chat_room:" <> room_name, _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", payload, socket) do
    broadcast(socket, "new_message", payload)

    {:noreply, socket}
  end
end
