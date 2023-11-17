defmodule InfoCnpj.Doc do
  use Plug.Builder

  plug Plug.Static,
    at: "/doc", from: {:info_cnpj, "priv/static/doc"}

  plug :not_found

  defp not_found(conn, _opts) do
    send_resp(conn, 404, "Not Found")
  end
end
