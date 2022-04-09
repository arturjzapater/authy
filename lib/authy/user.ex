defmodule Authy.User do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  @required_for_new [:username, :email, :password]
  @required_for_change [:username, :email]

  schema "users" do
    field :username, :string
    field :email, :string
    field :last_login, :utc_datetime_usec
    field :password, :string, redact: true

    timestamps()
  end

  def changeset(user, params) do
    user
    |> Ecto.Changeset.cast(params, [:username, :email, :last_login, :password])
    |> Ecto.Changeset.validate_required(get_required(user))
    |> Ecto.Changeset.validate_length(:username, max: 40)
    |> Ecto.Changeset.validate_length(:email, max: 100)
    |> Ecto.Changeset.unique_constraint([:username, :email])
    |> hash_password()
  end

  defp get_required(%{id: nil}), do: @required_for_new
  defp get_required(_user), do: @required_for_change

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    hash = Bcrypt.hash_pwd_salt(password)
    Ecto.Changeset.put_change(changeset, :password, hash)
  end

  defp hash_password(changeset), do: changeset
end
