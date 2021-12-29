defmodule CampaignsApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CampaignsApi.Repo,
      # Start the Telemetry supervisor
      CampaignsApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CampaignsApi.PubSub},
      # Start the Endpoint (http/https)
      CampaignsApiWeb.Endpoint
      # Start a worker by calling: CampaignsApi.Worker.start_link(arg)
      # {CampaignsApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CampaignsApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CampaignsApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
