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

        @desc "Get the current user"
        field :current_user, type: :user_type do
            middleware Middleware.Authorize, :any
            resolve &Resolvers.UserResolver.user/3
        end

        @desc "Get a list of all teams"
        field :teams, list_of(:team_type) do
            middleware Middleware.Authorize, :any
            resolve &Resolvers.TeamResolver.teams/3
        end

        @desc "Get a list of all my joined teams"
        field :my_teams, list_of(:team_type) do
            middleware Middleware.Authorize, :any
            resolve &Resolvers.TeamResolver.my_teams/3
        end

        @desc "Get all messages for a given channel"
        field :messages, list_of(:message_type) do
            arg :channel_id, non_null(:id)
            middleware Middleware.Authorize, :any
            resolve &Resolvers.MessageResolver.messages/3
        end

        @desc "Get all direct messages"
        field :direct_messages, list_of(:direct_message_type) do
            arg :input, non_null(:direct_message_query_type)
            middleware Middleware.Authorize, :any
            resolve &Resolvers.DirectMessageResolver.get_direct_messages/3
        end

        @desc "Get a list of direct messaged users of a team"
        field :direct_messaged_users, list_of(:user_type) do
            arg :team_id, non_null(:id)
            middleware Middleware.Authorize, :any
            resolve &Resolvers.DirectMessageResolver.get_direct_messaged_users/3
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
            middleware Middleware.Authorize, :any
            resolve &Resolvers.TeamResolver.create_team/3
        end

        @desc "Add a user to a team"
        field :add_user_to_team, type: :member_type do
            arg :input, non_null(:member_input_type)
            middleware Middleware.Authorize, :any
            resolve &Resolvers.TeamResolver.add_member_to_team/3
        end

        @desc "Create a Channel"
        field :create_channel, type: :channel_type do
            arg :input, non_null(:channel_input_type)
            middleware Middleware.Authorize, :any
            resolve &Resolvers.ChannelResolver.create_channel/3
        end

        @desc "Create a Message"
        field :create_message, type: :message_type do
            arg :input, non_null(:message_input_type)
            middleware Middleware.Authorize, :any
            resolve &Resolvers.MessageResolver.create_message/3
        end

        @desc "Create a direct Message"
        field :create_direct_message, type: :direct_message_type do
            arg :input, non_null(:direct_message_input_type)
            middleware Middleware.Authorize, :any
            resolve &Resolvers.DirectMessageResolver.create_direct_message/3
        end
    end

    subscription do

        @desc "Subscribe to channel"
        field :new_channel_message, type: :message_type do
            arg :channel_id, non_null(:id)
            
            config fn args, _info ->
                {:ok, topic: args.channel_id}
            end

            trigger :create_message, topic: fn message ->
                message.channel_id
            end

            resolve fn message, _, _ -> 
                {:ok, message} 
            end
        end

        # @desc "Subscribe to direct message channel"
        # field :new_direct_channel_message, type: :direct_message_type do
        #     arg :input, non_null(:direct_message_input_type)
            
        #     config fn args, _info ->
        #         {:ok, topic: args.channel_id}
        #     end

        #     trigger :create_direct_message, topic: fn direct_message ->
        #         direct_message.channel_id
        #     end

            # resolve fn message, _, _ -> 
            #     {:ok, message} 
            # end
        # end
    end
end