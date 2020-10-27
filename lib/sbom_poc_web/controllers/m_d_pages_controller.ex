defmodule SbomPocWeb.MDPagesController do
  use SbomPocWeb, :controller

  def status(conn, params) do
    status = SbomPoc.Post.all_status()
    render(conn, "status.html", status: status)
  end

  def show_status(conn, %{"id" => id}) do
    status = SbomPoc.Post.get_status_by_id!(id)
    render(conn, "show_status.html", status: status)
  end
end
