defmodule TwixirWeb.InitAssigns do
  import Phoenix.LiveView

  def on_mount(:default, _params, session, socket) do
    socket =
      socket
      |> assign_new(:current_user, fn ->
        with user_token when not is_nil(user_token) <- session["user_token"],
          %Twixir.Accounts.User{} = user <- Twixir.Accounts.get_user_by_session_token(user_token),
          do: user
      end)
    {:cont, socket}
  end
end
