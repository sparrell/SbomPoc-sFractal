defmodule SbomPoc.Repo do
  use Ecto.Repo,
    otp_app: :sbomPoc,
    adapter: Ecto.Adapters.Postgres
end
