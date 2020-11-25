defmodule ChatterWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "chat_room:*", ChatterWeb.ChatRoomChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.

  @impl true
  def connect(%{"token" => token, "email" => email}, socket, _connect_info) do
    # max_age: 1209600 is equivalent to two weeks in seconds
    socket = assign(socket, :email, email)
    case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
      {:ok, user_id} ->
        socket = assign(socket, :user, user_id)
      _ -> socket
    end
    {:ok, socket}
  end

  @impl true
  def connect(_, _, _connect_info) do
    :error
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     ChatterWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(_socket), do: nil
end
