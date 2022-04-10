defmodule Authy.Repo.Migrations.CreateTokens do
  use Ecto.Migration

  def change do
    create table(:tokens, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :user_id,
          references(:users, type: :uuid, on_delete: :delete_all, on_update: :update_all),
          null: false

      add :token, :string, null: false

      add :data, :json, null: false, default: fragment("'{}'::json")

      timestamps(updated_at: false, type: :utc_datetime_usec, default: fragment("now()"))
    end
  end
end
