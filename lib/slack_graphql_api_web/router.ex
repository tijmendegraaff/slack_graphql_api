defmodule SlackGraphqlApiWeb.Router do
  use SlackGraphqlApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SlackGraphqlApiWeb do
    pipe_through :api
  end
end
