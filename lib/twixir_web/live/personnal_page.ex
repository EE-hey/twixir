defmodule TwixirWeb.PersonnalPage do

  use Phoenix.LiveView, layout: {TwixirWeb.LayoutView, "live.html"}
  import Ecto.Query
  alias Twixir.Accounts.User
  alias Twixir.Repo
  alias Twixir.Twix


  def mount(_params =%{"id" => id}, session, socket) do

    IO.inspect(socket.assigns.current_user)
    twixs = User.twix_by_user_id(User, id)
    socket = assign(socket, twixs: twixs)
    socket = assign(socket, visited_page: id)
    TwixirWeb.Endpoint.subscribe("twixir#{id}")
    {:ok, socket}
  end

  def handle_event("send_twix", value, socket) do
    %{
      "twix" => twix,
    } = value
    user_id = socket.assigns.current_user.id
    Twix.post_twix(twix, user_id)
    twixs = User.twix_by_user_id(User, socket.assigns.visited_page)
    socket = assign(socket, twixs: twixs)
    TwixirWeb.Endpoint.broadcast!("twixir#{socket.assigns.current_user.id}", "update", %{id: socket.assigns.current_user.id})
    {:noreply, socket}
  end

  def handle_info(%{event: "update", payload: payload}, socket) do
    twixs = User.twix_by_user_id(User, payload.id)
    socket = assign(socket, twixs: twixs)
    {:noreply, socket}
  end

  def render(assigns) do

    ~H"""

    <div>
      <form phx-submit="send_twix"  style="display: flex; flex-direction: row;">
        <input type="text" name="twix" id="twix" />
        <button>Twix</button>
      </form>
    </div>

    <table>
    <%= for user <- @twixs do %>

      <%= for twix <- user.twixs do %>
      <tr><td><%= user.email %></td><td> <%= twix.content %></td></tr>
      <% end %>
    <% end %>
    </table>


    """

  end

end
