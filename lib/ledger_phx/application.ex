defmodule LedgerPhx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LedgerPhxWeb.Telemetry,
      LedgerPhx.Repo,
      {DNSCluster, query: Application.get_env(:ledger_phx, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LedgerPhx.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LedgerPhx.Finch},
      # Start a worker by calling: LedgerPhx.Worker.start_link(arg)
      # {LedgerPhx.Worker, arg},
      # Start to serve requests, typically the last entry
      LedgerPhxWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LedgerPhx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LedgerPhxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
