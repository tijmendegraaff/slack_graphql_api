defmodule SlackGraphqlApi.Messenger.Member do
    use Ecto.Schema
    import Ecto.Changeset
    alias SlackGraphqlApi.Accounts.User
    alias SlackGraphqlApi.Messenger.Team
  
    @primary_key false
    schema "members" do
        belongs_to :user, User
        belongs_to :team, Team
    end
  
    @doc false
    def changeset(team, attrs) do
      team
      |> cast(attrs, [:team_id, :user_id])
      |> validate_required([:team_id, :user_id])
    end
  end
  