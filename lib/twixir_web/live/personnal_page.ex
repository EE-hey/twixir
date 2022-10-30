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

    <div class="w-full">
      <form phx-submit="send_twix"  class=" mx-32 flex flew-row w-full">
        <input type="text" name="twix" id="twix" class="w-96 rounded border-grey-200 mr-4" />
        <button class="shadow rounded bg-blue-800 w-96 text-white">Twix</button>
      </form>
    </div>

    <div class="mx-32  ">
    <%= for user <- @twixs do %>

      <%= for twix <- user.twixs do %>

      <div class="my-16 px-4 py-8 bg-grey-200  shadow rounded-lg">
        <div class="px-16 py-8">
          <div class="flex flex-row">
            <img class="rounded-full object-cover h-16 w-16 ..." src="https://pixabay.com/static/img/profile_image_dummy.svg" />
            <span class="inline-block align-middle"><%= user.email %> </span>
          </div>
        </div>
        <div class="px-16 py-8"><%= twix.content %></div>
      </div>
      <% end %>
    <% end %>
    </div>


    """

  end

end
