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
    action item - replace phoenic logo
    with plugfest logo
    <h1>Home page </h1>
    Info on sfractal machines:
    <bl>
      <li>sbompoc.sfractal.com</li>
      <li>twinklymaha.sfractal.com</li>
      <li>twinklyhaha.sfractal.com</li>
      <li>blinkymaha.sfractal.com</li>
      <li>blinkyhaha.sfractal.com</li>
      <li>vulnerable.twinklymaha.sfractal.com</li>
      <li> </li>
    </bl>
    <h2>sbompoc.sfractal.com</h2>
    <p>This is running on GCP vm buddhabrot</p>
    <p>/ is this home page</p>
    <p>/events is mqtt log </p>
    <p>/phoenix is phoenix info page </p>
    <p>/dashboard is beam under-the-hood info for debugging</p>
    <p> </p>
    <p>more stuff</p>
    <h2>x.sfractal.com</h2>
    <p> </p>
    <h2>x.sfractal.com</h2>
    <p> </p>
    <h2>x.sfractal.com</h2>
    <p> </p>
    """
  end


end
