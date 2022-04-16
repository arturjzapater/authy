defmodule Authy.User.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Authy.User.Token

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime_usec]

  @required_for_new [:username, :email, :password]
  @required_for_change [:username, :email]

  schema "users" do
    field :username, :string
    field :email, :string
    field :last_login, :utc_datetime_usec
    field :password, :string, redact: true

    timestamps()

    has_many :tokens, Token
  end

  def changeset(user, params) do
    user
    |> cast(params, [:username, :email, :last_login, :password])
    |> validate_required(get_required(user))
    |> validate_length(:username, max: 40)
    |> validate_length(:email, max: 100)
    |> unique_constraint([:username, :email])
    |> hash_password()
  end

  defp get_required(%{id: nil}), do: @required_for_new
  defp get_required(_user), do: @required_for_change

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    hash = Bcrypt.hash_pwd_salt(password)
    put_change(changeset, :password, hash)
  end

  defp hash_password(changeset), do: changeset
end
