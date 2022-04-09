defmodule Authy.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid
      add :username, :string, size: 40, null: false
      add :email, :string, size: 100, null: false
      add :last_login, :utc_datetime_usec

      timestamps(type: :utc_datetime_usec, default: fragment("now()"))
    end
  end
end
