defmodule SlackGraphqlApiWeb.Resolvers.UserResolver do
    alias SlackGraphqlApi.Accounts

    def users(_,_,_) do
        {:ok, Accounts.list_users}
    end
end