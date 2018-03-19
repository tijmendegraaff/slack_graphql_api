defmodule SlackGraphqlApiWeb.Schema do
    use Absinthe.Schema

    alias SlackGraphqlApiWeb.Schema.Middleware
    alias SlackGraphqlApiWeb.Resolvers

    import_types SlackGraphqlApiWeb.Schema.Types
    
    def middleware(middleware, _field, %{identifier: :mutation}) do
        middleware ++ [Middleware.ChangesetErrors]
    end
    
    def middleware(middleware, _field, _object) do
        middleware
    end

    query do
        @desc "Get a list of all users"
        field :users, list_of(:user_type) do
            middleware Middleware.Authorize, :any
            resolve &Resolvers.UserResolver.users/3
        end

        @desc "Get a single user"
        field :user, type: :user_type do
            middleware Middleware.Authorize, :any
            resolve &Resolvers.UserResolver.user/3
        end

        @desc "Get a list of all teams"
        field :teams, list_of(:team_type) do
            middleware Middleware.Authorize, :any
            resolve &Resolvers.TeamResolver.teams/3
        end
    end

    mutation do
        @desc "Register a user"
        field :create_user, type: :user_type do
            arg :input, non_null(:user_input_type)
            resolve &Resolvers.UserResolver.create_user/3
        end

        @desc "Login as a user and grab a JWT token"
        field :create_session, type: :session_type do
            arg :input, non_null(:session_input_type)
            resolve &Resolvers.UserResolver.login/3
        end

        @desc "Create a Team"
        field :create_team, type: :team_type do
            arg :input, non_null(:team_input_type)
            resolve &Resolvers.TeamResolver.create_team/3
        end

        @desc "Create a Channel"
        field :create_channel, type: :channel_type do
            arg :input, non_null(:channel_input_type)
            resolve &Resolvers.ChannelResolver.create_channel/3
        end
    end

end