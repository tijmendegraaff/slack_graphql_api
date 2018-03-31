defmodule SlackGraphqlApiWeb.Resolvers.UploadImageResolver do
  alias SlackGraphqlApi.Messenger

  def get_image_upload_url(_, %{input: input}, _) do
    IO.inspect(input)
    {:ok, Messenger.get_presigned_url(input.model_name)}
  end
end
