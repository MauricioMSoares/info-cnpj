defmodule InfoCnpjWeb.VerifyCnpjLive do
  alias InfoCnpj.Companies
  alias InfoCnpj.Companies.Company

  use InfoCnpjWeb, :live_view

  import Brcpfcnpj, only: [cnpj_valid?: 1]

  def mount(_params, _session, socket) do
    cnpj_valid = false
    has_data = false
    company = %Company{}

    {:ok, assign(socket, cnpj_valid: cnpj_valid, has_data: has_data, company: company)}
  end

  def handle_event("validate", attrs, socket) do
    cnpj = get_cnpj_from_attrs(attrs)

    {:noreply, assign(socket, :cnpj_valid, cnpj_valid?(cnpj))}
  end

  def handle_event("find", %{"cnpj" => cnpj}, socket) do
    cnpj = extract_cnpj_number(cnpj)
    company = Companies.get_company_by_cnpj(cnpj)

    case company do
      %Company{} ->
        IO.inspect("Encontrei no banco")
        IO.inspect(company)
        {:noreply, assign(socket, :company, company)}

      _ ->
        data = Companies.get_company_from_api(cnpj)
        company = Companies.create_company_struct_from_json(data)
        Companies.create_retrieved_company(company)

        IO.inspect("Trouxe de lá da API")
        IO.inspect(company)

        {:noreply, assign(socket, :company, company)}
    end
  end

  defp get_cnpj_from_attrs(attrs) do
    attrs |> Map.get("cnpj")
  end

  @cnpj_regex ~r/(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/

  defp extract_cnpj_number(cnpj) do
    case Regex.match?(@cnpj_regex, cnpj) do
      true ->
        Regex.replace(@cnpj_regex, cnpj, "\\1\\2\\3\\4\\5")

      false ->
        nil
    end
  end
end
