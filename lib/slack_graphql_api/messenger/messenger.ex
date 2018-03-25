defmodule SlackGraphqlApi.Messenger do
  import Ecto.Query, warn: false
  import Ecto.Query, only: [from: 2]

  alias SlackGraphqlApi.Repo
  alias SlackGraphqlApi.Messenger.{Team, Member, Channel, Message, ChannelMember}
  alias SlackGraphqlApi.Accounts.User

  def list_teams() do
    Repo.all(Team)
  end

  def list_my_teams(user) do
    Ecto.assoc(user, :teams)
    |> Repo.all()
  end

  def get_team!(id), do: Repo.get!(Team, id)

  def create_team(attrs \\ %{}) do
    with {:ok, team} <- %Team{} |> Team.changeset(attrs) |> Repo.insert() do
      with {:ok, member} <-
             %Member{}
             |> Member.changeset(%{user_id: attrs.user_id, team_id: team.id})
             |> Repo.insert() do
        channel =
          %{name: "general", team_id: team.id, user_id: attrs.user_id}
          |> create_channel

        {:ok, team}
      end
    end
  end

  def create_channel(args \\ %{}) do
    IO.inspect(args)

    case team = Repo.get(Team, args.team_id) do
      nil ->
        {:error, "Team does not exsist"}

      _ ->
        case args.user_id === team.user_id do
          false ->
            {:error, "Unauthorized"}

          true ->
            with {:ok, channel} <- %Channel{} |> Channel.changeset(args) |> Repo.insert() do
              %ChannelMember{user_id: args.user_id, channel_id: channel.id} |> Repo.insert()
              {:ok, channel}
            end
        end
    end
  end

  def create_direct_message_channel(args) do
    team = Repo.get(Team, args.team_id)

    if team do
      channel = check_if_channel_already_exists(args, team)

      if channel == false do
        with {:ok, new_channel} <- %Channel{} |> Channel.changeset(args) |> Repo.insert() do
          Enum.each(args.members, fn member ->
            user = Repo.get!(User, member)
            %ChannelMember{user_id: user.id, channel_id: new_channel.id} |> Repo.insert()
          end)

          new_channel
        end
      else
        channel
      end
    else
      {:error, "Team does not exist"}
    end
  end

  def create_message(args) do
    %Message{}
    |> Message.changeset(args)
    |> Repo.insert()
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
    query =
      from(p in Message, where: p.channel_id == ^args.channel_id, order_by: p.inserted_at)
      |> Repo.all()
  end

  def create_member(args) do
    case user = Repo.get_by(User, email: args.email) do
      nil ->
        {:error, "user not found"}

      _ ->
        case team = Repo.get(Team, args.team_id) do
          nil ->
            {:error, "team not found"}

          _ ->
            %Member{}
            |> Member.changeset(%{user_id: user.id, team_id: team.id})
            |> Repo.insert()
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

  def check_if_channel_already_exists(args, team) do
    user_list = Enum.map(args.members, fn member -> Repo.get!(User, member) end)
    user_id_list = Enum.map(user_list, fn user -> user.id end)

    query = """
      select c.id, c.name 
      from channels as c, channel_members cm 
      where cm.channel_id = c.id and 
      c.is_direct_message_channel = true and 
      c.is_public = false and c.team_id = $1
      group by c.id, 
      c.name having array_agg(cm.user_id) @> $2
      and count(cm.user_id) = $3
    """

    result =
      Ecto.Adapters.SQL.query!(Repo, query, [team.id, user_id_list, Enum.count(user_id_list)])

    IO.inspect(result)

    cond do
      result.num_rows == 0 ->
        false

      result.num_rows != 0 ->
        first_element_of_result = Enum.at(result.rows, 0)
        channel_id = Enum.at(first_element_of_result, 0)
        Repo.get!(Channel, channel_id)
    end
  end
end
