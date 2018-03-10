defmodule SlackGraphqlApiWeb.Resolvers.UserResolver do
    alias SlackGraphqlApi.Accounts

    def users(_,_,_) do
        {:ok, Accounts.list_users}
    end

    def create_user(_,%{input: input},_) do
        IO.inspect(input)
        Accounts.create_user(input)
    end
end