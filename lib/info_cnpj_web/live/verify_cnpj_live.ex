defmodule InfoCnpjWeb.VerifyCnpjLive do
  alias DBConnection.Task
  alias InfoCnpj.Companies
  alias InfoCnpj.Companies.Company

  use InfoCnpjWeb, :live_view

  import Brcpfcnpj, only: [cnpj_valid?: 1]

  def mount(_params, _session, socket) do
    cnpj_valid = false
    company = %Company{}

    {:ok, assign(socket, cnpj_valid: cnpj_valid, company: company)}
  end

  def handle_event("validate", attrs, socket) do
    cnpj = get_cnpj_from_attrs(attrs)

    {:noreply, assign(socket, :cnpj_valid, cnpj_valid?(cnpj))}
  end

  def handle_event("find", %{"cnpj" => cnpj}, socket) do
    company = Companies.get_company_by_cnpj(cnpj)

    case company do
      %Company{} ->
        {:noreply, assign(socket, :company, company)}

      nil ->
        IO.inspect("Não achei, vou procurar no Google")
        data = get_company_from_api(cnpj)

        IO.inspect("Achei no Google, agora vou salvar no banco")
        Companies.create_company(%Company{
          cnpj: cnpj,
          company_type: data.root.estabelecimento.tipo,
          country: data.root.estabelecimento.pais.nome,
          county: data.root.estabelecimento.cidade.nome,
          district: data.root.estabelecimento.bairro,
          enterprise_name: data.root.razao_social,
          fantasy_name: data.root.estabelecimento.nome_fantasia,
          cep: data.root.cep,
          number: data.root.estabelecimento.numero,
          opening_date: data.root.estabelecimento.data_inicio_atividade,
          phone_ddd: data.root.estabelecimento.ddd1,
          phone_number: data.root.estabelecimento.telefone1,
          public_place: data.root.estabelecimento.logradouro
        })

        {:noreply, assign(socket, :company, company)}
    end
  end

  defp get_cnpj_from_attrs(attrs) do
    attrs |> Map.get("cnpj")
  end

  defp get_company_from_api(cnpj) do
    case HTTPoison.get!(
           "https://publica.cnpj.ws/cnpj/#{cnpj}"
         ) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}

      {:ok, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
