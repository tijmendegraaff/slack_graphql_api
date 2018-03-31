defmodule SlackGraphqlApiWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias SlackGraphqlApiWeb.Schema.Types

  # import your types
  import_types(Types.UserType)
  import_types(Types.SessionType)
  import_types(Types.TeamType)
  import_types(Types.ChannelType)
  import_types(Types.MessageType)
  import_types(Types.MemberType)
  import_types(Types.UploadImageUrlType)
end
