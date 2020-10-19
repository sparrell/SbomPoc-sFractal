defmodule SbomPocWeb.MDPagesController do
  use SbomPocWeb, :controller

  def status(conn, params) do
    status = SbomPoc.Post.all_status()
    render(conn, "status.html", status: status)
  end
end
