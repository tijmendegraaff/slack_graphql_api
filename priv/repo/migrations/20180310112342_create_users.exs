defmodule SlackGraphqlApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :user_name, :string
      add :email, :string
      add :password_hash, :string
      add :role, :string
      add :reset_password_token, :string
      add :reset_password_sent_at, :utc_datetime

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end
