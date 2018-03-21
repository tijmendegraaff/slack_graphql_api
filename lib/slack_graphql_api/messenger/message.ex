defmodule SlackGraphqlApi.Messenger.Message do
    use Ecto.Schema
    import Ecto.Changeset
    alias SlackGraphqlApi.Accounts.User
    alias SlackGraphqlApi.Messenger.Channel
  
    
    schema "messages" do
      field :content, :string
      belongs_to :channel, Channel
      belongs_to :user, User
  
      timestamps()
    end
  
    @doc false
    def changeset(message, attrs) do
      message
      |> cast(attrs, [:content, :user_id, :channel_id])
      |> validate_required([:content, :user_id, :channel_id])
    end
end
  