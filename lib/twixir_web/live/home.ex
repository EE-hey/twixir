defmodule TwixirWeb.Home do
  use Phoenix.LiveView, layout: {TwixirWeb.LayoutView, "live.html"}
  alias Twixir.{Subscription, Repo, Twix}
  import Ecto.Query
  def mount(_params, session, socket) do
    subscriptions = Subscription
    |> where([s], s.follower == ^socket.assigns.current_user.id)
    |> select([s], s.user_id)
    |> Repo.all

    Enum.map(subscriptions, fn(x) -> TwixirWeb.Endpoint.subscribe("twixir#{x}") end )

    twixs = Enum.map(subscriptions, fn(x) -> Twix
    |> preload([u], :user)
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


  def handle_info(%{event: "update", payload: %{id: _}}, socket) do
    IO.inspect("message reçu !!!!!!!!")
    subscriptions = Subscription
    |> where([s], s.follower == ^socket.assigns.current_user.id)
    |> select([s], s.user_id)
    |> Repo.all

    twixs = Enum.map(subscriptions, fn(x) -> Twix
    |> preload([u], :user)
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

    <div class="mx-32  ">
    <%= for t <- @twixs do %>
      <div class="my-16 px-4 py-8 bg-grey-200  shadow rounded-lg">
        <div class="px-16 py-8">
          <div class="flex flex-row">
            <img class="rounded-full object-cover h-16 w-16 ..." src="https://pixabay.com/static/img/profile_image_dummy.svg" />
            <span class="inline-block align-middle"><%= t.user.email %></span>
          </div>
        </div>
        <div class="px-16 py-8"><%= t.content %></div>
      </div>
    <% end %>
    </div>
    """
  end

end
