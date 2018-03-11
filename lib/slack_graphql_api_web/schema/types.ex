defmodule SlackGraphqlApiWeb.Schema.Types do
    use Absinthe.Schema.Notation
    
    alias SlackGraphqlApiWeb.Schema.Types
    
    # import your types
    import_types Types.UserType
    import_types Types.SessionType

  end