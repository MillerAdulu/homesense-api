defmodule Homesenseapi.Repo do
  use Ecto.Repo,
    otp_app: :homesenseapi,
    adapter: Ecto.Adapters.Postgres
end
