defmodule SlackGraphqlApi.Accounts.Session do
    alias SlackGraphqlApi.Accounts.User
    alias SlackGraphqlApi.Repo

    def authenticate(args) do
        user = Repo.get_by(User, email: String.downcase(args.email))
        case check_password(user, args) do
            true -> {:ok, user}
            _ -> {:error, "Incorrect login credentials"}
        end
    end

    defp check_password(user, params) do
        case user do
          nil -> Comeonin.Argon2.dummy_checkpw()
          _ -> Comeonin.Argon2.checkpw(params.password, user.password_hash)
        end
    end

end