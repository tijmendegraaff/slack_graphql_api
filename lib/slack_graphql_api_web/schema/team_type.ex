defmodule SlackGraphqlApiWeb.Schema.Types.TeamType do
    use Absinthe.Schema.Notation
    use Absinthe.Ecto, repo: SlackGraphqlApi.Repo

    object :team_type do
        field :id, :id
        field :name, :string
    end

    input_object :team_input_type do
        field :name, non_null(:string)
    end

end