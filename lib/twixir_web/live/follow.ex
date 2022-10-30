defmodule TwixirWeb.Follow do

  use Phoenix.LiveView
  alias Twixir.Accounts.User
  alias Twixir.Subscription

  def mount(_params, _session, socket) do
    users = User.find_all_users()
    socket = assign(socket, users: users)
    {:ok, socket}
  end

  def handle_event("subscribe", value, socket) do
    %{
      "id" => follower_id
    } = value
    follower_id = String.to_integer(follower_id)
    IO.inspect(value)
    Subscription.user_subscribe_to_user(follower_id,socket.assigns.current_user.id)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
      <h2>Find someone to follow</h2>
      <table>
      <%= for user <- @users do %>
        <tr><td><%= user.email %></td><td><button phx-click="subscribe" phx-value-id={user.id}>Subscribe</button></td></tr>
      <% end %>
      </table>

    """
  end





end
