defmodule InfoCnpjWeb.VerifyCnpjLive do
  use InfoCnpjWeb, :live_view

  alias InfoCnpj.Companies
  alias InfoCnpj.Companies.Company

  import Brcpfcnpj, only: [cnpj_valid?: 1]

  def mount(_params, _session, socket) do
    cnpj_valid = false

    IO.inspect("Printa aqui")
    {:ok, assign(socket, :cnpj_valid, cnpj_valid)}
  end

  def handle_event("validate", attrs, socket) do
    cnpj =
      attrs
      |> Map.get("cnpj")

    {:noreply, assign(socket, :cnpj_valid, cnpj_valid?(cnpj))}
  end
end
