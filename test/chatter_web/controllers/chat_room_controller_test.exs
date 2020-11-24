defmodule ChatterWeb.ChatRoomControllerTest do
  use ChatterWeb.ConnCase, async: true

  describe "create/2" do
    test "render new page with invalid params", %{conn: conn} do
      #user = build(:user) |> set_password("superpassword") |> insert()
      room = insert(:chat_room, name: "elixir")
      params = string_params_for(:chat_room, name: room.name)

      response =
        conn
        |> sign_in()
        |> post(Routes.chat_room_path(conn, :create), %{"room" => params})
        |> html_response(200)

      assert response =~ "has already been taken"
    end
  end

  def sign_in(conn) do
    user = build(:user) |> set_password("password") |> insert()
    conn
    |> Plug.Test.init_test_session(%{})
    |> Doorman.Login.Session.login(user)
  end
end
