defmodule LedgerPhx.Repo do
  use Ecto.Repo,
    otp_app: :ledger_phx,
    adapter: Ecto.Adapters.Postgres
end
