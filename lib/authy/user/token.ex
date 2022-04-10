defmodule Authy.User.Token do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime_usec]

  schema "tokens" do
    field :token, :string
    field :data, :json
    belongs_to :user, Authy.User.User

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:token, :user_id, :data])
    |> validate_required([:token, :user_id, :data])
    |> foreign_key_constraint(:user_id)
  end
end
