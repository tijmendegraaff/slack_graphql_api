defmodule SlackGraphqlApiWeb.Schema.Types.DirectMessageType do
    use Absinthe.Schema.Notation
    use Absinthe.Ecto, repo: SlackGraphqlApi.Repo

    object :direct_message_type do
        field :id, :id
        field :content, :string
        field :inserted_at, :string
        field :sender, :user_type, resolve: assoc(:user)
        field :receiver, :user_type, resolve: assoc(:user)
    end

    input_object :direct_message_input_type do
        field :content, non_null(:string)
        field :team_id, non_null(:id)
        field :receiver_id, non_null(:id)
    end

    input_object :direct_message_query_type do
        field :team_id, non_null(:id)
        field :receiver_id, non_null(:id)
    end

end