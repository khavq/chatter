defmodule ChatterWeb.UserCreatesNewChatRoomTest do
  use ChatterWeb.FeatureCase, async: true

  test "user can visit list room page and create a new room", %{session: session} do
    user = insert(:user)
    #user |> IO.inspect(label: "UUUUU")

    session
    |> visit("/")
    |> sign_in(as: user)
    |> click(new_chat_room_link())
    |> create_chat_room(name: "elixir")
    |> assert_has(room_title("elixir"))
  end

  defp new_chat_room_link, do: Query.link("New chat room")
  defp create_chat_room(session, name) do
    session
    |> fill_in(Query.text_field("Name"), with: "elixir")
    |> click(Query.button("Submit"))
  end
  defp room_title(title) do
    Query.data("role", "room-title", text: title)
  end
end
