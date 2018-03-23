defmodule SlackGraphqlApi.Messenger.DirectMessage do
    use Ecto.Schema
    import Ecto.Changeset
    alias SlackGraphqlApi.Accounts.User
    alias SlackGraphqlApi.Messenger.Team
  
    
    schema "direct_messages" do
      field :content, :string
      belongs_to :team, Team
      belongs_to :sender, User, foreign_key: :sender_id
      belongs_to :receiver, User, foreign_key: :receiver_id
  
      timestamps()
    end
  
    @doc false
    def changeset(message, attrs) do
      message
      |> cast(attrs, [:content, :sender_id, :receiver_id, :team_id])
      |> validate_required([:content, :sender_id, :receiver_id, :team_id])
      |> foreign_key_constraint(:team, name: :direct_message_id_fkey, message: "must exist")
    end
end
  