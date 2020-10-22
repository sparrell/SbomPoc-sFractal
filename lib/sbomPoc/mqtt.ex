defmodule SbomPoc.Mqtt do
  @moduledoc """
  `Mqtt` is main module for handling mqtt
  mqtt.start initializes the system
     and starts the Tortoise mqtt client using mqtt.handler
  """

  require Logger

  @doc """
  Start initializes system variables
  and starts supervisor of mqtt client
  """
  def start do
    client_id =
      System.get_env("CLIENT_ID") ||
        raise """
        environment variable CLIENT_ID is missing.
        For example:
        export CLIENT_ID=:mqttlogger
        """

    Logger.info("client_id is #{client_id}")

    mqtt_host =
      System.get_env("MQTT_HOST") ||
        raise """
        environment variable HOST is missing.
        Examples:
        export MQTT_HOST="34.86.117.113"
        export MQTT_HOST="mqtt.sfractal.com"
        """

    Logger.info("mqtt_host is #{mqtt_host}")

    mqtt_port =
      String.to_integer(
        System.get_env("MQTT_PORT") ||
          raise("""
          environment variable MQTT_PORT is missing.
          Example:
          export MQTT_PORT=1883
          """)
      )

    Logger.info("mqtt_port is #{mqtt_port}")

    server = {Tortoise.Transport.Tcp, host: mqtt_host, port: mqtt_port}

    user_name =
      System.get_env("USER_NAME") ||
        raise """
        environment variable USER_NAME is missing.
        Examples:
        export USER_NAME="plug"
        """

    Logger.info("user_name is #{user_name}")

    password =
      System.get_env("PASSWORD") ||
        raise """
        environment variable PASSWORD is missing.
        Example:
        export PASSWORD="fest"
        """

    Logger.info("password set")

    Logger.info("Creating events table...")
    :events_table = SbomPoc.Mqtt.Handler.create_events_table()

    {:ok, _} =
      Tortoise.Supervisor.start_child(
        Oc2Mqtt.Connection.Supervisor,
        client_id: client_id,
        handler: {SbomPoc.Mqtt.Handler, [name: client_id]},
        server: server,
        user_name: user_name,
        password: password,
        subscriptions: [{"#", 0}]
      )
  end
end
