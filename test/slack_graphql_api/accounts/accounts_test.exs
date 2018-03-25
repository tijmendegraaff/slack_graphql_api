defmodule SlackGraphqlApi.AccountsTest do
  use SlackGraphqlApi.DataCase

  alias SlackGraphqlApi.Accounts

  describe "users" do
    alias SlackGraphqlApi.Accounts.User

    @valid_attrs %{
      email: "some email",
      first_name: "some first_name",
      last_name: "some last_name",
      password_hash: "some password_hash",
      reset_password_sent_at: "2010-04-17 14:00:00.000000Z",
      reset_password_token: "some reset_password_token",
      role: "some role",
      user_name: "some user_name"
    }
    @update_attrs %{
      email: "some updated email",
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      password_hash: "some updated password_hash",
      reset_password_sent_at: "2011-05-18 15:01:01.000000Z",
      reset_password_token: "some updated reset_password_token",
      role: "some updated role",
      user_name: "some updated user_name"
    }
    @invalid_attrs %{
      email: nil,
      first_name: nil,
      last_name: nil,
      password_hash: nil,
      reset_password_sent_at: nil,
      reset_password_token: nil,
      role: nil,
      user_name: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.password_hash == "some password_hash"

      assert user.reset_password_sent_at ==
               DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")

      assert user.reset_password_token == "some reset_password_token"
      assert user.role == "some role"
      assert user.user_name == "some user_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.password_hash == "some updated password_hash"

      assert user.reset_password_sent_at ==
               DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")

      assert user.reset_password_token == "some updated reset_password_token"
      assert user.role == "some updated role"
      assert user.user_name == "some updated user_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
