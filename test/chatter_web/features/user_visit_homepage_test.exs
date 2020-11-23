defmodule ChatterWeb.UserVisitHomePageTest do
  use ChatterWeb.FeatureCase, async: true

  test "user can visit home page", %{session: session} do
    session
    |> visit("/")
    |> assert_has(Query.css(".title", text: "Welcome to Chatter!"))
  end
end
