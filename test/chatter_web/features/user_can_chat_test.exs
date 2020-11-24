defmodule ChatterWeb.UserCanChatTest do
  use ChatterWeb.FeatureCase, async: true

  test "user can chat with anothers successfully", %{metadata: metadata} do
    room = insert(:chat_room)

    user =
      metadata
      |> new_user()
      |> visit(rooms_index())
      |> join_room(room.name)

    another_user =
      metadata
      |> new_user()
      |> visit(rooms_index())
      |> join_room(room.name)

    user
    |> send_message("Hi everyone")

    another_user
    |> assert_has(message("Hi everyone"))
    |> send_message("Hi, welcome to #{room.name}")

    user
    |> assert_has(message("Hi, welcome to #{room.name}"))

  end

  defp message(message) do
    Query.data("role", "message", text: message)
  end

  defp new_user(metadata) do
    {:ok, user} = Wallaby.start_session(metadata: metadata)
    user
  end

  def send_message(session, message) do
    session
    |> fill_in(Query.text_field("New Message"), with: message)
    |> click(Query.button("Send"))
  end

  def rooms_index, do: Routes.chat_room_path(@endpoint, :index)
  def join_room(session, name) do
    session |> click(Query.link(name))
  end
end
