# CampaignsApi

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.create` then `mix ecto.migrate`
- Getting data from a csv file located at "priv/repo/data/campaigns.csv" `mix run priv/repo/seeds.exs`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To observe available endpoints:
You can visist [`localhost:4000/api/swagger`](http://localhost:4000/api/swagger)

To update campaign.csv:

- Add more data into "campaigns.csv" file or replace it with a new one with the same name "campaigns.csv".
- Re-run `mix run priv/repo/seeds.exs` (old inputs will not be duplicated).

- Inputs that got deleted through Delete requests will be restored also by re-run `mix run priv/repo/seeds.exs` if it's still in campaigns.csv

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
