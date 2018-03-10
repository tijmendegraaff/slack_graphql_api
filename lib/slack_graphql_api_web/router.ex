defmodule SlackGraphqlApiWeb.Router do
  use SlackGraphqlApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: SlackGraphqlApiWeb.Schema

    if Mix.env == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: SlackGraphqlApiWeb.Schema
    end
  end
end
