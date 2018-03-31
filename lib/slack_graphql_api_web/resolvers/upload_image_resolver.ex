defmodule SlackGraphqlApiWeb.Resolvers.UploadImageResolver do
  alias SlackGraphqlApi.Messenger

  def get_image_upload_url(_, %{input: input}, _) do
    {:ok, Messenger.get_presigned_url(input.model_name)}
  end
end
