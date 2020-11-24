defmodule ChatterWeb.UserVisitHomePageTest do
  use ChatterWeb.FeatureCase, async: true

  test "user can visit home page", %{session: session} do
    user = build(:user) |> set_password("superpassword") |> insert()
    session
    |> visit("/")
    |> sign_in(as: user)
    |> assert_has(Query.css(".title", text: "Welcome to Chatter!"))
  end
end
