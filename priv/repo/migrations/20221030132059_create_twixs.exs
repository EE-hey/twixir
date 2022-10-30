defmodule Twixir.Repo.Migrations.CreateTwixs do
  use Ecto.Migration

  def change do
    create table(:twixs) do
      add :user_id, :integer
      add :content, :string

      timestamps()
    end
  end
end
