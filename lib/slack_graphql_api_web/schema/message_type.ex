defmodule SlackGraphqlApiWeb.Schema.Types.MessageType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: SlackGraphqlApi.Repo

  object :message_type do
    field(:id, :id)
    field(:content, :string)
    field(:inserted_at, :string)
    field(:user, :user_type, resolve: assoc(:user))
  end

  input_object :message_input_type do
    field(:content, non_null(:string))
    field(:channel_id, non_null(:id))
  end

  input_object :message_query_input_type do
    field(:channel_id, non_null(:id))
    field(:cursor, :string)
  end
end
