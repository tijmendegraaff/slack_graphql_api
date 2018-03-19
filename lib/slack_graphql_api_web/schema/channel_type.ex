defmodule SlackGraphqlApiWeb.Schema.Types.ChannelType do
    use Absinthe.Schema.Notation
    use Absinthe.Ecto, repo: SlackGraphqlApi.Repo

    object :channel_type do
        field :id, :id
        field :name, :string
        field :owner, :user_type, resolve: assoc(:user)
        field :is_private, :boolean
    end

    input_object :channel_input_type do
        field :name, non_null(:string)
        field :team_id, non_null(:id)
        field :is_public, non_null(:boolean)
    end

end