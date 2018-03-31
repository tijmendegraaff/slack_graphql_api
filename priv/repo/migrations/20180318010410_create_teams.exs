defmodule SlackGraphqlApi.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:teams, [:user_id])
    create unique_index(:teams, [:name])
  end
end
