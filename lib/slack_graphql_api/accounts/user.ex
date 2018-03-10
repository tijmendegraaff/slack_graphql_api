defmodule SlackGraphqlApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackGraphqlApi.Accounts.User

  schema "users" do
    field :user_name, :string, unique: true
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
  # def changeset(user, attrs) do
  #   user
  #   |> cast(attrs, [:first_name, :last_name, :user_name, :email, :password_hash, :role, :reset_password_token, :reset_password_sent_at])
  #   |> validate_required([:first_name, :last_name, :user_name, :email, :password_hash, :role, :reset_password_token, :reset_password_sent_at])
  # end

  def registration_changeset(%User{} = user, params \\ %{}) do
    user
    |> cast(params, [:email, :first_name, :last_name, :password, :user_name])
    |> validate_required([:email, :first_name, :last_name, :password, :role, :user_name])
    |> unique_constraint(:user_name)
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &(String.downcase(&1)))
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6, max: 100)
    |> hash_password()
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Argon2.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
