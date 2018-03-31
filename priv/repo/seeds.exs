# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SlackGraphqlApi.Repo.insert!(%SlackGraphqlApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias SlackGraphqlApi.Accounts


for _ <- 1..5 do
    Accounts.create_user(%{first_name: Faker.Name.first_name(), last_name: Faker.Name.last_name(), user_name: Faker.Internet.user_name(), email: Faker.Internet.email(), password: "password"})
end