defmodule SlackGraphqlApi.Messenger.Team do
  use Ecto.Schema
  import Ecto.Changeset


  schema "teams" do
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 30)
    |> unique_constraint(:name)
  end
end
