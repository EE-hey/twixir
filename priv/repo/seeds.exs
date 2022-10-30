# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Twixir.Repo.insert!(%Twixir.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Ecto.Query
alias Twixir.Accounts.User
alias Twixir.Twix
alias Twixir.Repo
alias Twixir.Subscription




Repo.insert(%Twix{content: "This is my first twix", user_id: 1})
Repo.insert(%Twix{content: "Wahou the lors of the ring is amazing", user_id: 1})
Repo.insert(%Twix{content: "Elixir is also an amazing programming language", user_id: 1})
Repo.insert(%Twix{content: "Should I drink tea or coffe ?", user_id: 1})
Repo.insert(%Twix{content: "Hello ! Lets listen to music", user_id: 1})
Repo.insert(%Twix{content: "Am I fucking alone on this social media ? Is anybody out there ?", user_id: 1})
Repo.insert(%Twix{content: "Blah blah blah", user_id: 1})
Repo.insert(%Twix{content: "Sono italiano ma non parlo bene questa lingua !!!", user_id: 1})
