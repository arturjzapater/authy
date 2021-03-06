defmodule Authy.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :username, :string, size: 40, null: false, unique: true
      add :email, :string, size: 100, null: false, unique: true
      add :last_login, :utc_datetime_usec
      add :password, :text

      timestamps(type: :utc_datetime_usec, default: fragment("now()"))
    end
  end
end
