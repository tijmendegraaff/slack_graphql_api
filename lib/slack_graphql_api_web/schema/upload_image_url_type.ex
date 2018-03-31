defmodule SlackGraphqlApiWeb.Schema.Types.UploadImageUrlType do
  use Absinthe.Schema.Notation

  object :upload_image_url_type do
    field(:image_url, non_null(:string))
    field(:upload_url, non_null(:string))
  end

  input_object :upload_image_url_input_type do
    field(:model_name, non_null(:string))
  end
end
