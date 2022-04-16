defmodule Authy.User.Token do
  use Ecto.Schema
  import Ecto.Changeset

  alias Authy.User.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime_usec]

  schema "tokens" do
    field :token, :string
    field :agent, :string
    field :os, :string
    belongs_to :user, User

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(token, attrs) do
    token
    |> cast(attrs, [:token, :user_id, :agent, :os])
    |> validate_required([:token, :user_id, :agent, :os])
    |> foreign_key_constraint(:user_id)
  end
end
