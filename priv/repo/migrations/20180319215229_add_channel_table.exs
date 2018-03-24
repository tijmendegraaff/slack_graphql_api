defmodule SlackGraphqlApi.Repo.Migrations.AddChannelTable do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :name, :string
      add :is_public, :boolean, default: true, null: false
      add :is_direct_message_channel, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :team_id, references(:teams, on_delete: :nothing)

      timestamps()
    end
  end
end
