# defmodule SlackGraphqlApi.MessengerTest do
#   use SlackGraphqlApi.DataCase

#   alias SlackGraphqlApi.Messenger

#   describe "teams" do
#     alias SlackGraphqlApi.Messenger.Team

#     @valid_attrs %{name: "some name"}
#     @update_attrs %{name: "some updated name"}
#     @invalid_attrs %{name: nil}

#     def team_fixture(attrs \\ %{}) do
#       {:ok, team} =
#         attrs
#         |> Enum.into(@valid_attrs)
#         |> Messenger.create_team()

#       team
#     end

#     test "list_teams/0 returns all teams" do
#       team = team_fixture()
#       assert Messenger.list_teams() == [team]
#     end

#     test "get_team!/1 returns the team with given id" do
#       team = team_fixture()
#       assert Messenger.get_team!(team.id) == team
#     end

#     test "create_team/1 with valid data creates a team" do
#       assert {:ok, %Team{} = team} = Messenger.create_team(@valid_attrs)
#       assert team.name == "some name"
#     end

#     test "create_team/1 with invalid data returns error changeset" do
#       assert {:error, %Ecto.Changeset{}} = Messenger.create_team(@invalid_attrs)
#     end

#     test "update_team/2 with valid data updates the team" do
#       team = team_fixture()
#       assert {:ok, team} = Messenger.update_team(team, @update_attrs)
#       assert %Team{} = team
#       assert team.name == "some updated name"
#     end

#     test "update_team/2 with invalid data returns error changeset" do
#       team = team_fixture()
#       assert {:error, %Ecto.Changeset{}} = Messenger.update_team(team, @invalid_attrs)
#       assert team == Messenger.get_team!(team.id)
#     end

#     test "delete_team/1 deletes the team" do
#       team = team_fixture()
#       assert {:ok, %Team{}} = Messenger.delete_team(team)
#       assert_raise Ecto.NoResultsError, fn -> Messenger.get_team!(team.id) end
#     end

#     test "change_team/1 returns a team changeset" do
#       team = team_fixture()
#       assert %Ecto.Changeset{} = Messenger.change_team(team)
#     end
#   end
# end
