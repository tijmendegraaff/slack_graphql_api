defmodule SlackGraphqlApiWeb.Schema.Types.MessageType do
    use Absinthe.Schema.Notation
    use Absinthe.Ecto, repo: SlackGraphqlApi.Repo

    object :message_type do
        field :id, :id
        field :content, :string
    end

    input_object :message_input_type do
        field :content, non_null(:string)
        field :channel_id, non_null(:id)
    end

end