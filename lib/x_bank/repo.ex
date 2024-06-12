defmodule XBank.Repo do
  use Ecto.Repo,
    otp_app: :x_bank,
    adapter: Ecto.Adapters.Postgres
end
