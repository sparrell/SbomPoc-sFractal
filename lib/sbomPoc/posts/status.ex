defmodule SbomPoc.Post.Status do
  @moduledoc false
  @enforce_keys [:author, :body]
  defstruct [:id, :author, :title, :body, :description, :tags]

  def build(filename, attrs, body) do
    struct!(__MODULE__, [body: body] ++ Map.to_list(attrs))
  end
end
