defmodule User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, :string
    field :name, :string
    field :proficiency, :string
    field :gender, :string
    field :relationships_status, :string
    field :password_hash, :string
    field :nickname, :string

    timestamps()
  end

  def changeset(user, attrs), do:
    cast(user, attrs, ~w(nickname name relationships_status gender proficiency)a)
end
