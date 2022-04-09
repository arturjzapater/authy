defmodule Authy.UserTest do
  use Authy.DataCase

  alias Authy.User

  describe "tokens" do
    alias Authy.User.Token

    import Authy.UserFixtures

    @invalid_attrs %{token: nil}

    test "list_tokens/0 returns all tokens" do
      token = token_fixture()
      assert User.list_tokens() == [token]
    end

    test "get_token!/1 returns the token with given id" do
      token = token_fixture()
      assert User.get_token!(token.id) == token
    end

    test "create_token/1 with valid data creates a token" do
      valid_attrs = %{token: "some token"}

      assert {:ok, %Token{} = token} = User.create_token(valid_attrs)
      assert token.token == "some token"
    end

    test "create_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_token(@invalid_attrs)
    end

    test "update_token/2 with valid data updates the token" do
      token = token_fixture()
      update_attrs = %{token: "some updated token"}

      assert {:ok, %Token{} = token} = User.update_token(token, update_attrs)
      assert token.token == "some updated token"
    end

    test "update_token/2 with invalid data returns error changeset" do
      token = token_fixture()
      assert {:error, %Ecto.Changeset{}} = User.update_token(token, @invalid_attrs)
      assert token == User.get_token!(token.id)
    end

    test "delete_token/1 deletes the token" do
      token = token_fixture()
      assert {:ok, %Token{}} = User.delete_token(token)
      assert_raise Ecto.NoResultsError, fn -> User.get_token!(token.id) end
    end

    test "change_token/1 returns a token changeset" do
      token = token_fixture()
      assert %Ecto.Changeset{} = User.change_token(token)
    end
  end
end
