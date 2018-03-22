defmodule SlackGraphqlApiWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: SlackGraphqlApiWeb.Schema

  transport :websocket, Phoenix.Transports.WebSocket
 
  def connect(%{"token" => token}, socket) do
    case SlackGraphqlApi.Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        case SlackGraphqlApi.Guardian.resource_from_claims(claims) do
          {:ok, user} ->
            socket = Absinthe.Phoenix.Socket.put_options(socket, context: %{
              current_user: user
            })
            IO.inspect(socket)
            {:ok, socket}
          {:error, _reason} ->
            :error
        end
      {:error, _reason} ->
        :error
    end
  end

  def connect(_params, _socket), do: :error

  def id(_socket), do: nil
end
