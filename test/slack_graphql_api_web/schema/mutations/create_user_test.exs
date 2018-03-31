defmodule SlackGraphqlApiWeb.Schema.Mutation.CreateUserTest do
  use SlackGraphqlApiWeb.ConnCase, async: true

  import SlackGraphqlApi.Factory

  @query """
  mutation createUser($input: UserInputType!) {
    createUser(input: $input){
      id
      firstName
      lastName
      userName
      email
    }
  }
  """

  test "create user mutation creates a new user" do
    user = build(:user)

    response =
      post(build_conn(), "/api/graphql", %{
        query: @query,
        variables: %{
          "input" => %{
            "firstName" => user.first_name,
            "lastName" => user.last_name,
            "userName" => user.user_name,
            "email" => user.email,
            "password" => user.password
          }
        }
      })

    assert %{"data" => %{"createUser" => user_data}} = json_response(response, 200)
    assert user.first_name == user_data["firstName"]
    assert user.last_name == user_data["lastName"]
    assert user.user_name == user_data["userName"]
    assert user.email == user_data["email"]
  end

  test "create user mutation shows an error when email is invalid" do
    user = build(:user, email: "merel.com")

    response =
      post(build_conn(), "/api/graphql", %{
        query: @query,
        variables: %{
          "input" => %{
            "userName" => user.user_name,
            "firstName" => user.first_name,
            "lastName" => user.last_name,
            "email" => user.email,
            "password" => user.password
          }
        }
      })

    assert %{
             "data" => %{"createUser" => user_data},
             "errors" => [%{"key" => error_key, "message" => error_message}]
           } = json_response(response, 200)

    assert user_data == nil
    assert error_key == "email"
    assert List.first(error_message) == "has invalid format"
  end
end
