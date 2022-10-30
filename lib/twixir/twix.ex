defmodule Twixir.Twix do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twixir.Repo
  alias Twixir.Accounts.User
  alias Twixir.Twix

  schema "twixs" do
    field :content, :string
    belongs_to :user, Twixir.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(twix, attrs) do
    twix
    |> cast(attrs, [:user_id, :content])
    |> validate_required([:user_id, :content])
  end


  def post_twix(twix, user_id) do
    Repo.insert!(%Twix{user_id: user_id, content: twix})
  end





end
