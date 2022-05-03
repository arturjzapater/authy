defmodule Authy.User do
  @moduledoc """
  The User context.
  """

  import Bcrypt, only: [check_pass: 2]
  import Ecto.Query, warn: false
  alias Authy.Repo

  alias Authy.User.Token
  alias Authy.User.User

  def login(%{"username" => username, "password" => password}) do
    username
    |> get_by_username()
    |> check_pass(password)
  end

  def logout(token) do
    Repo.delete_all(from t in Token, where: t.token == ^token)
  end

  def get_by_token(token) do
    Repo.one!(from u in User, left_join: t in assoc(u, :tokens), where: t.token == ^token)
  end

  def get_by_username(username) do
    Repo.one(from u in User, where: u.username == ^username)
  end

  @doc """
  Creates a token.

  ## Examples

      iex> create_token(%{field: value})
      {:ok, %Token{}}

      iex> create_token(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_token(attrs \\ %{}) do
    %Token{}
    |> Token.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a token.

  ## Examples

      iex> delete_token(token)
      {:ok, %Token{}}

      iex> delete_token(token)
      {:error, %Ecto.Changeset{}}

  """
  def delete_token(%Token{} = token) do
    Repo.delete(token)
  end
end
