defmodule SlackGraphqlApi.Factory do
  use ExMachina.Ecto, repo: SlackGraphqlApi.Repo

  alias SlackGraphqlApi.Accounts.User
  alias SlackGraphqlApi.Messenger.Team

  def user_factory do
    %User{
      first_name: sequence(:first_name, &"R#{&1}ny"),
      last_name: sequence(:last_name, &"de #{&1}"),
      user_name: sequence(:user_name, &"Username #{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "password"
    }
  end

  def team_factory do
    %Team{}
  end
end
