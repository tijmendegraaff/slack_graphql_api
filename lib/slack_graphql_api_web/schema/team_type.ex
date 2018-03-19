defmodule SlackGraphqlApiWeb.Schema.Types.TeamType do
    use Absinthe.Schema.Notation
    use Absinthe.Ecto, repo: SlackGraphqlApi.Repo

    object :team_type do
        field :id, :id
        field :name, :string
        field :owner, :user_type, resolve: assoc(:user)
        field :members, list_of(:user_type), resolve: assoc(:users)
        field :channels, list_of(:channel_type), resolve: assoc(:channels)
        
    end

    input_object :team_input_type do
        field :name, non_null(:string)
    end

end