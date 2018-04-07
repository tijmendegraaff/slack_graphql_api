defmodule SlackGraphqlApiWeb.Schema.Mutation.CreateTeamTest do
  use SlackGraphqlApiWeb.ConnCase, async: true

  import SlackGraphqlApi.Factory

  @query """
  mutation createUser($input: UserInputType!) {
    createUser(input: $input){
      id
      name
      description
      avatar
      owner
    }
  }
  """
end
