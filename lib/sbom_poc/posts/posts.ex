defmodule SbomPoc.Post do
  @moduledoc false
  alias SbomPoc.Post.Status

  use NimblePublisher,
    build: Status,
    from: "status/**/*.md",
    as: :status

  def all_status, do: @status

  def get_status_by_id!(id) do
    Enum.find(all_status(), &(&1.id == id)) ||
      raise NotFoundError, "status with id=#{id} not found"
  end
end

defmodule NotFoundError do
  defexception [:message, plug_status: 404]
end
