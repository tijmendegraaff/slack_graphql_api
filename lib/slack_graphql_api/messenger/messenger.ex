defmodule SlackGraphqlApi.Messenger do

  import Ecto.Query, warn: false
  import Ecto.Query, only: [from: 2]
  
  alias SlackGraphqlApi.Repo
  alias SlackGraphqlApi.Messenger.{Team, Member, Channel, Message}
  alias SlackGraphqlApi.Accounts.User

  def list_teams() do
    Repo.all(Team)
  end

  def list_my_teams(user) do
    Ecto.assoc(user, :teams)
    |> Repo.all
  end

  def get_team!(id), do: Repo.get!(Team, id)

  def create_team(attrs \\ %{}) do
    with {:ok, team} <- %Team{} |> Team.changeset(attrs) |> Repo.insert do
      with {:ok, member} <- %Member{user_id: attrs.user_id, team_id: team.id} |> Repo.insert do
        channel = %{name: "general", team_id: team.id, user_id: attrs.user_id}
        |> create_channel
        {:ok, team}
      end
    end
  end

  def create_channel(attrs \\ %{}) do
    %Channel{}
    |> Channel.changeset(attrs)
    |> Repo.insert
  end

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert
  end

  def create_member(args) do
    with user <- Repo.get_by(User, email: args.email) do
      with team <- Repo.get(Team, args.team_id) do
        member = %{user_id: user.id, team_id: team.id}
        %Member{}
        |> Member.changeset(member)
        |> Repo.insert
      end
    end
  end

  # def update_team(%Team{} = team, attrs) do
  #   team
  #   |> Team.changeset(attrs)
  #   |> Repo.update()
  # end

  # def delete_team(%Team{} = team) do
  #   Repo.delete(team)
  # end

  # def change_team(%Team{} = team) do
  #   Team.changeset(team, %{})
  # end
end
