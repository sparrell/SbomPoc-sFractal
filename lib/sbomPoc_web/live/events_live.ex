defmodule SbomPocWeb.EventsLive do
  @moduledoc "Events page live view"
  use SbomPocWeb, :live_view

  @topic "new_event"

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(SbomPoc.PubSub, @topic)

    events = SbomPoc.Mqtt.Handler.all_events()
    {:ok, assign(socket, events: events)}
  end

  def render(assigns) do
    ~L"""
    <h1>Events page view </h1>
    <%= if Enum.empty? @events do %>
    <h2> No events yet </h2>
    <% else %>
    <table>
      <thead>
        <tr>
          <th>Time</th>
          <th>Topic</th>
          <th>Message</th>
        </tr>
      </thead>
      <tbody>
      <%= for {time, details} <- @events do %>
        <tr>
        <td><%= time %></td>
        <td><%= details.topic %></td>
        <td><%= details.message %></td>
        </tr>
       <% end %>
      </tbody>
    </table>
    <% end %>
    """
  end

  def handle_info({"new_event", %{event: event}}, socket) do
    events = [event | socket.assigns.events]
    {:noreply, assign(socket, events: events)}
  end
end
