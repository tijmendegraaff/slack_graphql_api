defmodule SlackGraphqlApiWeb.Schema.Types.MemberType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: SlackGraphqlApi.Repo

  object :member_type do
    field(:team_id, non_null(:id))
    field(:user_id, non_null(:id))
  end

  input_object :member_input_type do
    field(:team_id, non_null(:id))
    field(:email, non_null(:string))
  end
end
