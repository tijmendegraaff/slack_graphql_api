defmodule SlackGraphqlApi.Repo.Migrations.AddDirectMessageTable do
  use Ecto.Migration

  def change do
    create table(:direct_messages) do
      add :content, :string
      add :sender_id, references(:users, on_delete: :nothing)
      add :receiver_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end
    create index(:direct_messages, [:receiver_id, :sender_id, :team_id])
  end
end
