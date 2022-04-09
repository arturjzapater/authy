defmodule Authy.UserFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Authy.User` context.
  """

  @doc """
  Generate a token.
  """
  def token_fixture(attrs \\ %{}) do
    {:ok, token} =
      attrs
      |> Enum.into(%{
        token: "some token"
      })
      |> Authy.User.create_token()

    token
  end
end
