defmodule InfoCnpj.Repo do
  use Ecto.Repo,
    otp_app: :info_cnpj,
    adapter: Ecto.Adapters.Postgres
end
