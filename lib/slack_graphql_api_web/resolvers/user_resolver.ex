defmodule SlackGraphqlApiWeb.Resolvers.UserResolver do
    alias SlackGraphqlApi.{Accounts, Guardian}

    def user(_,_,%{context: %{user: user}}) do
        {:ok, Accounts.get_user!(user.id)}
    end

    def users(_,_,%{context: %{user: user}}) do
        {:ok, Accounts.list_users}
    end

    def create_user(_,%{input: input},_) do
        IO.inspect(input)
        Accounts.create_user(input)
    end

    def login(_,%{input: input},_) do
        with {:ok, user} <- Accounts.Session.authenticate(input),
             {:ok, jwt, _ } <- Guardian.encode_and_sign(user) do
          {:ok, %{token: jwt}}
        end
    end
end