defmodule SbomPocWeb.HomeLive do
  @moduledoc "Home page live view"
  use SbomPocWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    #Phoenix.PubSub.subscribe(SbomPoc.PubSub, @topic)

    #events = SbomPoc.Mqtt.Handler.all_events()
    {:ok, assign(socket, home: "whatever")}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h1>Home page view </h1>
    stuff
    """
  end


end
