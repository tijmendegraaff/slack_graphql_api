defmodule SlackGraphqlApiWeb.Resolvers.DirectMessageResolver do
    alias SlackGraphqlApi.Messenger

    def create_direct_message(_,%{input: input}, %{context: %{user: user}}) do
        args = Map.merge(input, %{sender_id: user.id})
        |> IO.inspect
        Messenger.create_direct_message(args)
    end

    def get_direct_messages(_,%{input: input}, %{context: %{user: user}}) do
        args = Map.merge(input, %{sender_id: user.id})
        IO.inspect(args)
        {:ok, Messenger.list_direct_messages(args)}
    end

    def get_direct_messaged_users(_, input, %{context: %{user: user}}) do
        result = Map.merge(input, %{user_id: user.id})
        |> Messenger.list_direct_messages_users()
        IO.inspect(result)
    end

end