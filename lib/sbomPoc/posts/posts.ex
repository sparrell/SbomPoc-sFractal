defmodule SbomPoc.Post do
  alias SbomPoc.Post.Status

  use NimblePublisher,
    build: Status,
    from: "status/**/*.md",
    as: :status

  def all_status, do: @status
end
