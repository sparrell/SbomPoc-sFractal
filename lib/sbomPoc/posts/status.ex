defmodule SbomPoc.Post.Status do
  @moduledoc false
  @enforce_keys [:id, :author, :body]
  defstruct [:id, :author, :title, :body, :description, :tags]

  def build(filename, attrs, body) do
    [_, id] = filename |> Path.rootname() |> Path.split() |> Enum.take(-2)
    struct!(__MODULE__, [body: body, id: id] ++ Map.to_list(attrs))
  end
end
