defmodule SlackGraphqlApi.Messenger.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias SlackGraphqlApi.Accounts.User
  alias SlackGraphqlApi.Messenger.{Channel, Member, DirectMessages}
  
  schema "teams" do
    field :name, :string
    belongs_to :user, User
    has_many :channels, Channel
    has_many :direct_messages, DirectMessages
    many_to_many :users, User, join_through: "members"

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
