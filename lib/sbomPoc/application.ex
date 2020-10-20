defmodule SbomPoc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SbomPoc.Repo,
      # Start the Telemetry supervisor
      SbomPocWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SbomPoc.PubSub},
      # Start the Endpoint (http/https)
      SbomPocWeb.Endpoint,
      # Start a worker by calling: SbomPoc.Worker.start_link(arg)
      # {SbomPoc.Worker, arg}
      {Tortoise.Supervisor,
       [
         name: Oc2Mqtt.Connection.Supervisor,
         strategy: :one_for_one
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SbomPoc.Supervisor]
    Supervisor.start_link(children, opts)
    SbomPoc.Mqtt.start()
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SbomPocWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
