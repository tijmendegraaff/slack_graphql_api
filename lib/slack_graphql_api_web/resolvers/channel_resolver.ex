defmodule SlackGraphqlApiWeb.Resolvers.ChannelResolver do
    alias SlackGraphqlApi.Messenger

    def create_channel(_,%{input: input},%{context: %{user: user}}) do
        args = Map.merge(input, %{user_id: user.id})
        Messenger.create_channel(args)
    end

end