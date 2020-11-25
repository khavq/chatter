defmodule Chatter.AccountsTest do
  use Chatter.DataCase, async: true
  alias Chatter.{Accounts, User}

  describe "change_user/1" do
    test "prepares a changeset for a new user" do
      assert %Ecto.Changeset{} = Accounts.change_user(%User{})
    end
  end

  describe "create_user/1" do
    test "create a user with valid email and password" do
      params = %{"email" => "example@email.com", "password" => "supermessi"}
      {:ok, user} = Accounts.create_user(params)

      assert user.id
      assert user.hashed_password
      assert user.session_secret
      assert user.email == params["email"]
    end
  end

  test "returns changeset if fails to create user" do
    params = %{"email" => "random@example.com", "password" => nil}

    {:error, changeset} = Accounts.create_user(params)

    assert "can't be blank" in errors_on(changeset).password
  end
end
