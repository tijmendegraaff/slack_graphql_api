defmodule SlackGraphqlApiWeb.Schema.Types.UserType do
    use Absinthe.Schema.Notation
    use Absinthe.Ecto, repo: SlackGraphqlApi.Repo

    object :user_type do
        field :id, :id
        field :first_name, :string
        field :last_name, :string
        field :user_name, :string
        field :email, :string
        field :role, :string
        field :owned_teams, list_of(:team_type), resolve: assoc(:owned_teams)
        field :teams, list_of(:team_type), resolve: assoc(:teams)
        # field :direct_messages, list_of(:direct_message_type), resolve: assoc(:direct_message)
    end

    input_object :user_input_type do
        field :first_name, non_null(:string)
        field :last_name, non_null(:string)
        field :user_name, non_null(:string)
        field :email, non_null(:string)
        field :password, non_null(:string)
    end

end