defmodule SlackGraphqlApiWeb.Resolvers.ChannelResolver do
  alias SlackGraphqlApi.Messenger
  alias SlackGraphqlApiWeb.Utils.StringGenerator
  import Ecto

  def list_private_channels(team, _, %{context: %{user: user}}) do
    {:ok, Messenger.list_my_private_channels(team, user)}
  end

  def list_channels(team, _, %{context: %{user: user}}) do
    {:ok, Messenger.list_my_channels(team, user)}
  end

  def create_channel(_, %{input: input}, %{context: %{user: user}}) do
    args = Map.merge(input, %{user_id: user.id})
    IO.inspect(args)
    Messenger.create_channel(args)
  end

  def create_direct_message_channel(_, %{input: input}, %{context: %{user: user}}) do
    new_memberlist = [user.id | input.members]
    channel_name = StringGenerator.string_of_length(20)
    x = Map.put(input, :members, new_memberlist)

    args =
      Map.merge(x, %{
        is_direct_message_channel: true,
        user_id: user.id,
        is_public: false,
        name: channel_name
      })

    IO.inspect(args)
    {:ok, Messenger.create_direct_message_channel(args)}
  end
end
