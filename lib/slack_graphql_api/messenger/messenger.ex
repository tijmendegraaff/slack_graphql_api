defmodule SlackGraphqlApi.Messenger do
  @moduledoc """
  The Messenger context.
  """

  import Ecto.Query, warn: false
  import Ecto.Query, only: [from: 2]
  alias SlackGraphqlApi.Repo
  alias SlackGraphqlApi.Accounts

  alias SlackGraphqlApi.Messenger.{Team, Member, Channel, Message}

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams() do
    Repo.all(Team)
  end

  def list_my_teams(user) do
    Ecto.assoc(user, :teams)
    |> Repo.all
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
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

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{source: %Team{}}

  """
  def change_team(%Team{} = team) do
    Team.changeset(team, %{})
  end
end
