defmodule SlackGraphqlApi.Repo.Migrations.CreateUsersTeams do
  use Ecto.Migration

  def change do
    create table(:members, primary_key: false) do
      add :user_id, references(:users)
      add :team_id, references(:teams)
    end
    create unique_index(:members, [:user_id, :team_id])
  end
end
