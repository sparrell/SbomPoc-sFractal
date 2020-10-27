defmodule SbomPoc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  def start(_type, _args) do
    client_id =
      System.get_env("CLIENT_ID") ||
        raise """
        environment variable CLIENT_ID is missing.
        For example:
        export CLIENT_ID=:mqttlogger
        """

    Logger.info("mqtt:application:client_id is #{client_id}")

    mqtt_host =
      System.get_env("MQTT_HOST") ||
        raise """
        environment variable HOST is missing.
        Examples:
        export MQTT_HOST="34.86.117.113"
        export MQTT_HOST="mqtt.sfractal.com"
        """

    Logger.info("mqtt:application:mqtt_host is #{mqtt_host}")

    mqtt_port =
      String.to_integer(
        System.get_env("MQTT_PORT") ||
          raise("""
          environment variable MQTT_PORT is missing.
          Example:
          export MQTT_PORT=1883
          """)
      )

    Logger.info("mqtt:application:mqtt_port is #{mqtt_port}")

    server = {Tortoise.Transport.Tcp, host: mqtt_host, port: mqtt_port}

    user_name =
      System.get_env("USER_NAME") ||
        raise """
        environment variable USER_NAME is missing.
        Examples:
        export USER_NAME="plug"
        """

    Logger.info("mqtt:application:user_name is #{user_name}")

    password =
      System.get_env("PASSWORD") ||
        raise """
        environment variable PASSWORD is missing.
        Example:
        export PASSWORD="fest"
        """

    Logger.info("mqtt:application:password set")

    Logger.info("mqtt:application:Creating events table...")
    :events_table = SbomPoc.Mqtt.Handler.create_events_table()

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

      ## orig way of starting mqtt which may be overkill
      ## {Tortoise.Supervisor,
      ## [
      ##   name: Oc2Mqtt.Connection.Supervisor,
      ##   strategy: :one_for_one
      ## ]}
      # trying another way
      {Tortoise.Connection,
       [
         client_id: client_id,
         server: server,
         handler: {SbomPoc.Mqtt.Handler, [name: client_id]},
         user_name: user_name,
         password: password,
         subscriptions: [{"#", 0}]
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SbomPoc.Supervisor]
    Supervisor.start_link(children, opts)
    ## SbomPoc.Mqtt.start()
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SbomPocWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
