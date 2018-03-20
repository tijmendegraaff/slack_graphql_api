defmodule SlackGraphqlApi.Messenger.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackGraphqlApi.Accounts.User
  alias SlackGraphqlApi.Messenger.{Channel, Member}
  
  schema "teams" do
    field :name, :string
    belongs_to :user, User
    many_to_many :users, User, join_through: "members"
    has_many :channels, Channel

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
    |> validate_length(:name, min: 1, max: 30)
    |> unique_constraint(:name)
  end
end
