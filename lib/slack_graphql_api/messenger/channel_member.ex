defmodule SlackGraphqlApi.Messenger.ChannelMember do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackGraphqlApi.Accounts.User
  alias SlackGraphqlApi.Messenger.Channel

  @primary_key false
  schema "channel_members" do
    belongs_to(:user, User)
    belongs_to(:channel, Channel)
  end

  @doc false
  def changeset(channel_member, attrs) do
    channel_member
    |> cast(attrs, [:channel_id, :user_id])
    |> validate_required([:channel_id, :user_id])
    |> unique_constraint(:user_id, name: :members_user_id_channel_id_index)
  end
end
