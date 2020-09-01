defmodule SbomPoc.Repo do
  use Ecto.Repo,
    otp_app: :sbom_poc,
    adapter: Ecto.Adapters.Postgres
end
