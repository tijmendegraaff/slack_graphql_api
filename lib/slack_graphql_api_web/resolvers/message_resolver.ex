defmodule SlackGraphqlApiWeb.Resolvers.MessageResolver do
    alias SlackGraphqlApi.Messenger

    def create_message(_,%{input: input},%{context: %{user: user}}) do
        args = Map.merge(input, %{user_id: user.id})
        Messenger.create_message(args)
    end

end