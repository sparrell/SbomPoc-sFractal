defmodule SbomPoc.Mqtt.Handler do
  @moduledoc """
  Mqtt.Handler is a behaviour of Tortoise for handling mqtt
  It allows for connections, subscriptons, and handles messages.
  The mqtt-specific code is here; and this module calls oc2 for
  OpenC2 parsing and execution
  """

  require Logger

  defstruct [:name, :events]
  alias __MODULE__, as: State

  @behaviour Tortoise.Handler

  @impl true
  def init(opts) do
    name = Keyword.get(opts, :name)
    create_events_table()

    {:ok, %State{name: name, events: []}}
  end

  @impl true
  def connection(:up, state) do
    Logger.debug("Connection has been established")
    {:ok, state}
  end

  @impl true
  def connection(:down, state) do
    Logger.warn("Connection has been dropped")
    {:ok, state}
  end

  @impl true
  def connection(:terminated, state) do
    Logger.warn("Connection has been terminated")
    {:ok, state}
  end

  @impl true
  def subscription(:up, topic, state) do
    Logger.debug("Subscribed to #{topic}")
    {:ok, state}
  end

  @impl true
  def subscription({:warn, [requested: req, accepted: qos]}, topic, state) do
    Logger.warn("Subscribed to #{topic}; requested #{req} but got accepted with QoS #{qos}")
    {:ok, state}
  end

  @impl true
  def subscription({:error, reason}, topic, state) do
    Logger.error("Error subscribing to #{topic}; #{inspect(reason)}")
    {:ok, state}
  end

  @impl true
  def subscription(:down, topic, state) do
    Logger.debug("Unsubscribed from #{topic}")
    {:ok, state}
  end

  @impl true
  def handle_message(topic, msg, state) do
    Logger.debug("Found a message")
    Logger.info("#{state.name}, #{Enum.join(topic, "/")} #{inspect(msg)}")
    record_event(Enum.join(topic, "/"), inspect(msg), state.name)

    {:ok, state}
  end

  @impl true
  def terminate(reason, _state) do
    Logger.warn("Client has been terminated with reason: #{inspect(reason)}")
    :ok
  end

  defp create_events_table do
    :ets.new(:events_table, [:set, :public, :named_table])
  end

  defp record_event(topic, msg, name) do
    data = {DateTime.utc_now(), %{name: name, topic: topic, message: msg}}
    :ets.insert(:events_table, data)
    _notify(data)
  end

  def all_events do
    :ets.tab2list(:events_table)
  end

  defp _notify(event) do
    Phoenix.PubSub.broadcast(SbomPoc.PubSub, "new_event", {"new_event", %{event: event}})
  end
end
