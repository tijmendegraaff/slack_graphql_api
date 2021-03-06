defmodule SlackGraphqlApi.Messenger.Channel do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackGraphqlApi.Accounts.User
  alias SlackGraphqlApi.Messenger.{Team, Message, ChannelMember}

  schema "channels" do
    field(:name, :string)
    field(:is_public, :boolean, default: true)
    field(:is_direct_message_channel, :boolean, default: false)
    belongs_to(:team, Team)
    belongs_to(:user, User)
    has_many(:messages, Message)
    many_to_many(:users, User, join_through: "channel_members")
    has_many(:channel_members, ChannelMember)

    timestamps()
  end

  @doc false
  def changeset(channel, attrs) do
    channel
    |> cast(attrs, [:name, :is_public, :user_id, :team_id, :is_direct_message_channel])
    |> validate_required([:name, :is_public, :user_id, :team_id, :is_direct_message_channel])
    |> validate_length(:name, min: 1, max: 30)
  end
end
