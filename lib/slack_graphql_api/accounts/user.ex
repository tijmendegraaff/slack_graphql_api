defmodule SlackGraphqlApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :reset_password_sent_at, :utc_datetime
    field :reset_password_token, :string
    field :role, :string
    field :user_name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :user_name, :email, :password_hash, :role, :reset_password_token, :reset_password_sent_at])
    |> validate_required([:first_name, :last_name, :user_name, :email, :password_hash, :role, :reset_password_token, :reset_password_sent_at])
  end
end
