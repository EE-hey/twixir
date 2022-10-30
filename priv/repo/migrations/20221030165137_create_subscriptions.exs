defmodule Twixir.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :user_id, :integer
      add :follower, :integer

      timestamps()
    end
  end
end
