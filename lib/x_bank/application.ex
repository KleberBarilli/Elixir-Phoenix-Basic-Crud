defmodule XBank.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      XBankWeb.Telemetry,
      XBank.Repo,
      {DNSCluster, query: Application.get_env(:x_bank, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: XBank.PubSub},
      # Start a worker by calling: XBank.Worker.start_link(arg)
      # {XBank.Worker, arg},
      # Start to serve requests, typically the last entry
      XBankWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: XBank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    XBankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
