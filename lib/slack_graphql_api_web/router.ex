defmodule SlackGraphqlApiWeb.Router do
  use SlackGraphqlApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug SlackGraphqlApiWeb.Plugs.Context
  end

  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: SlackGraphqlApiWeb.Schema,
      socket: SlackGraphqlApiWeb.UserSocket

    if Mix.env == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: SlackGraphqlApiWeb.Schema,
        socket: SlackGraphqlApiWeb.UserSocket
    end
  end
end
