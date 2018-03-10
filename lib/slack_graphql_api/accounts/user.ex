defmodule SlackGraphqlApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :user_name, :string
    field :email, :string, unique: true
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :role, :string, default: "user"
    field :reset_password_sent_at, :utc_datetime
    field :reset_password_token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :user_name, :email, :password_hash, :role, :reset_password_token, :reset_password_sent_at])
    |> validate_required([:first_name, :last_name, :user_name, :email, :password_hash, :role, :reset_password_token, :reset_password_sent_at])
  end
end
