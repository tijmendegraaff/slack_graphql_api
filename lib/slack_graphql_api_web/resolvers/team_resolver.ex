defmodule SlackGraphqlApiWeb.Resolvers.TeamResolver do
    alias SlackGraphqlApi.Messenger

    def create_team(_,%{input: input},%{context: %{user: user}}) do
        args = Map.merge(input, %{user_id: user.id})
        Messenger.create_team(args)
    end

    def teams(_,_,%{context: %{user: user}}) do
        {:ok, Messenger.list_teams}
    end

end