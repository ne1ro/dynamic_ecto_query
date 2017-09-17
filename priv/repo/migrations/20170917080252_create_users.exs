defmodule Repo.Migrations.CreateUsers do
  use Ecto.Migration

  @table :users

  def change do
    create table(@table, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :password_hash, :string, null: false
      add :nickname, :string, null: false
      add :name, :string, null: false
      add :relationships_status, :string
      add :gender, :string
      add :proficiency, :string, null: false

      timestamps()
    end

    create unique_index(@table, ~w(nickname)a)
  end
end
