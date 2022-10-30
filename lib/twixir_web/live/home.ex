defmodule TwixirWeb.Home do
  use Phoenix.LiveView
  alias Twixir.{Subscription, Repo, Twix}
  import Ecto.Query
  def mount(_params, session, socket) do
    subscriptions = Subscription
    |> where([s], s.follower == ^socket.assigns.current_user.id)
    |> select([s], s.user_id)
    |> Repo.all

    Enum.map(subscriptions, fn(x) -> TwixirWeb.Endpoint.subscribe("twixir#{x}") end )

    twixs = Enum.map(subscriptions, fn(x) -> Twix
    |> where([t], t.user_id == ^x)
    |> order_by([t], [asc: t.inserted_at])
    |> Repo.all end)
    |> Enum.concat()
    |> Enum.sort_by( fn(x) -> x.inserted_at end)
    |> Enum.reverse
    IO.inspect(twixs)

    socket = assign(socket, subscriptions: subscriptions, twixs: twixs)

    {:ok, socket}
  end


  def handle_info(%{event: "update", payload: payload}, socket) do

    subscriptions = Subscription
    |> where([s], s.follower == ^socket.assigns.current_user.id)
    |> select([s], s.user_id)
    |> Repo.all


    twixs = Enum.map(subscriptions, fn(x) -> Twix
    |> where([t], t.user_id == ^x)
    |> order_by([t], [asc: t.inserted_at])
    |> Repo.all end)
    |> Enum.concat()
    |> Enum.sort_by( fn(x) -> x.inserted_at end)
    |> Enum.reverse
    IO.inspect(twixs)

    socket = assign(socket, subscriptions: subscriptions, twixs: twixs)

    {:noreply, socket}

  end

  def render(assigns) do
    ~H"""
    <h2>My feed</h2>

    <table>
    <%= for t <- @twixs do %>
      <tr><td><%= t.user_id %></td><td><%= t.content %></td></tr>
    <% end %>
    </table>
    """
  end

end
