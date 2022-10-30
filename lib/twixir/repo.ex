defmodule Twixir.Repo do
  use Ecto.Repo,
    otp_app: :twixir,
    adapter: Ecto.Adapters.Postgres
end
