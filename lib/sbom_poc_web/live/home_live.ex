defmodule SbomPocWeb.HomeLive do
  @moduledoc "Home page live view"
  use SbomPocWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # Phoenix.PubSub.subscribe(SbomPoc.PubSub, @topic)

    # events = SbomPoc.Mqtt.Handler.all_events()
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
    </bl>
    <h2>sbompoc.sfractal.com</h2>
    <p>This is running on GCP vm buddhabrot</p>
    <p>home page http://sbompoc.sfractal.com:4000/</p>
    <p>events is mqtt log http://sbompoc.sfractal.com:4000/events</p>
    <p>??? is sbom and dependency tracker add-link-here</p>
    <p>phoenix is phoenix info page http://sbompoc.sfractal.com:4000/phoenix</p>
    <p>dashboard is beam under-the-hood info for debugging http://sbompoc.sfractal.com:4000/dashboard/sbom_poc%40buddhabrot/home</p>
    <p> </p>

    <h2>twinklymaha.sfractal.com</h2>
    <p>Twinkly (ie digital twin of blinky ie web leds)
    MaHa (ie Mqtt Api Helloworld Actuator)
    http://twinklymaha.sbompoc.sfractal.com:4000/</p>
    <h2>twinklyhaha.sfractal.com</h2>
    <p>Twinkly (ie digital twin of blinky ie web leds)
    HaHa (ie Http Api Helloworld Actuator)</p>
    <h2>blinkymaha.sfractal.com</h2>
    <p>Raspberry Pi with LEDs (ie Blinky)
    MaHa (ie Mqtt Api Helloworld Actuator)</p>
    <h2>blinkyhaha.sfractal.com</h2>
    <p>Raspberry Pi with LEDs (ie Blinky)
    HaHa (ie Http Api Helloworld Actuator)</p>
    """
  end
end
