defmodule SlackGraphqlApiWeb.Resolvers.ChannelResolver do
    alias SlackGraphqlApi.Messenger

    def create_channel(_,%{input: input},%{context: %{user: user}}) do
        args = Map.merge(input, %{user_id: user.id})
        IO.inspect(args)
        Messenger.create_channel(args)
    end

end