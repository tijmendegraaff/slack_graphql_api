defmodule SlackGraphqlApiWeb.Router do
  use SlackGraphqlApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SlackGraphqlApiWeb do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: AuthGraphqlApiWeb.Schema

    if Mix.env == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: AuthGraphqlApiWeb.Schema
    end
  end
end
