defmodule SlackGraphqlApi.Repo.Migrations.AddJoinedChannelUserTable do
  use Ecto.Migration

  def change do
    create table(:channel_members, primary_key: false) do
      add :user_id, references(:users)
      add :channel_id, references(:channels)
    end
    create unique_index(:channel_members, [:user_id, :channel_id])
  end
end
