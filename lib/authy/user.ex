defmodule Authy.User do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "users" do
    field :username, :string
    field :email, :string
    field :last_login, :utc_datetime_usec
  end

  def changeset(user, params \\ %{}) do
    user
    |> Ecto.Changeset.cast(params, [:username, :email, :last_login])
    |> Ecto.Changeset.validate_required([:username, :email])
    |> Ecto.Changeset.validate_length(:username, max: 40)
    |> Ecto.Changeset.validate_length(:email, max: 100)
  end
end
