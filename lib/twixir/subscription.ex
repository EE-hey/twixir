defmodule Twixir.Subscription do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twixir.Subscription
  alias Twixir.Repo

  schema "subscriptions" do
    field :follower, :integer
    belongs_to :user, Twixir.Accounts.User


    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:following, :follower])
    |> validate_required([:following, :follower])
  end

  def user_subscribe_to_user(follower_id,user_id) do
    Repo.insert(%Subscription{user_id: follower_id, follower: user_id})
  end


end
