defmodule SlackGraphqlApi.Messenger.Channel do
    use Ecto.Schema
    import Ecto.Changeset
    alias SlackGraphqlApi.Accounts.User
    alias SlackGraphqlApi.Messenger.{Team, Message}
  
    
    schema "channels" do
      field :name, :string
      field :is_public, :boolean, default: true
      belongs_to :team, Team
      belongs_to :user, User
      has_many :messages, Message
  
      timestamps()
    end
  
    @doc false
    def changeset(team, attrs) do
      team
      |> cast(attrs, [:name, :is_public, :user_id, :team_id])
      |> validate_required([:name, :is_public, :user_id, :team_id])
      |> validate_length(:name, min: 1, max: 30)
    end
  end
  