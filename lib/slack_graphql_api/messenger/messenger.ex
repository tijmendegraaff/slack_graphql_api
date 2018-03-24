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

  def create_channel(args \\ %{}) do
    case team = Repo.get(Team, args.team_id) do
      nil -> {:error, "Team does not exsist"}
      _ ->  case args.user_id === team.user_id do
              false -> {:error, "Unauthorized"}
              true -> %Channel{} |> Channel.changeset(args) |> Repo.insert
            end
    end
  end

  def create_message(args) do
    %Message{}
    |> Message.changeset(args)
    |> Repo.insert
  end

  # def create_direct_message(args) do
  #   %DirectMessage{}
  #   |> DirectMessage.changeset(args)
  #   |> Repo.insert
  # end

  # def list_direct_messages(args) do
  #     query = (
  #     from dm in DirectMessage,
  #     where: dm.team_id == ^args.team_id and dm.receiver_id == ^args.receiver_id and dm.sender_id == ^args.sender_id,
  #     or_where: dm.team_id == ^args.team_id and dm.receiver_id == ^args.sender_id and dm.receiver_id == ^args.sender_id,
  #     order_by: [asc: dm.inserted_at]
  #     )
  #     |> Repo.all()
  # end

  # def list_direct_messages_users(args) do
  #   query = (
  #     from dm in DirectMessage,
  #     where: dm.team_id == ^args.team_id and 
  #     dm.receiver_id == ^args.user_id or
  #     dm.sender_id == ^args.user_id, 
  #     select: [dm.receiver_id, dm.sender_id],
  #     distinct: true
  #     )
  #   |> Repo.all()
  # end

  def list_channel_messages(args) do
    query = (from p in Message, where: p.channel_id == ^args.channel_id, order_by: p.inserted_at)
    |> Repo.all()
  end

  def create_member(args) do
      case user = Repo.get_by(User, email: args.email) do
        nil -> {:error, "user not found"}
        _ ->
          case team = Repo.get(Team, args.team_id) do
            nil -> {:error, "team not found"}
            _ ->
              %Member{}
              |> Member.changeset(%{user_id: user.id, team_id: team.id})
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
