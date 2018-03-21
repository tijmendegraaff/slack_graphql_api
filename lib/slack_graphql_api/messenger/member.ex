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
    def changeset(member, attrs) do
      member
      |> cast(attrs, [:team_id, :user_id])
      |> validate_required([:team_id, :user_id])
      |> unique_constraint(:user_id, name: :members_user_id_team_id_index)
    end
  end
  