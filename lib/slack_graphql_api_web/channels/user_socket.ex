defmodule SlackGraphqlApiWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: SlackGraphqlApiWeb.Schema

  transport :websocket, Phoenix.Transports.WebSocket
 
  def connect(params, socket) do
    # current_user = current_user(params)
    # socket = Absinthe.Phoenix.Socket.put_opts(socket, context: %{
    #   current_user: current_user
    # })
    {:ok, socket}
  end

  def id(_socket), do: nil
end
