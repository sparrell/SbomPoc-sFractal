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
    <h1>Home page </h1>
    Info on sfractal machines:
    <bl>
      <li>sbompoc.sfractal.com</li>
      <li>analysis.sbompoc.sfractal.com</li>
      <li>twinklymaha.sfractal.com</li>
      <li>twinklyhaha.sfractal.com</li>
      <li>blinkymaha.sfractal.com</li>
      <li>blinkyhaha.sfractal.com</li>
      <li>vulnerable.twinklymaha.sfractal.com</li>
    </bl>
    <h2>sbompoc.sfractal.com</h2>
    <p>This is running on GCP vm buddhabrot</p>
    <p>home page
    <a href="http://sbompoc.sfractal.com:4000/">
    http://sbompoc.sfractal.com:4000/</a>
    </p>
    <p>events is mqtt log
    <a href="http://sbompoc.sfractal.com:4000/events">
    http://sbompoc.sfractal.com:4000/events</a>
    </p>
    <p>phoenix is phoenix info page
    <a href="http://sbompoc.sfractal.com:4000/phoenix">
    http://sbompoc.sfractal.com:4000/phoenix</a>
    </p>
    <p>dashboard is beam under-the-hood info for debugging
    <a href="http://sbompoc.sfractal.com:4000/dashboard/sbom_poc%40buddhabrot/home">
    http://sbompoc.sfractal.com:4000/dashboard/sbom_poc%40buddhabrot/home</a>
    </p>

    <h2>analysis.sbompoc.sfractal.com</h2>
    <p>sbom dependency/vulnerability http://analysis.sbompoc.sfractal.com:8080/</p>
    <p>has <a href="http://analysis.sbompoc.sfractal.com:8080/projects/4bf2c440-f4bf-4d4f-b02c-fea518b5d6a2">SbomPoc</a>
    and <a href="http://analysis.sbompoc.sfractal.com:8080/projects/f66c3983-35ab-4741-81b5-acab2a936ced">twinklymaha</a>
    SBOMs loaded.</p>
    <p>see component lists(one-hop plus, but not complete)
    by clicking on dependencies within project
    </p>

    <h2>twinklymaha.sfractal.com</h2>
    <p>Twinkly (ie digital twin of blinky ie web leds)
    MaHa (ie Mqtt Api Helloworld Actuator)
    <a href="http://twinklymaha.sbompoc.sfractal.com:4000/">
    http://twinklymaha.sbompoc.sfractal.com:4000/</a>
    </p>

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
