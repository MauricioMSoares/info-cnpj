defmodule InfoCnpjWeb.VerifyCnpjLive do
  alias DBConnection.Task
  alias InfoCnpj.Companies
  alias InfoCnpj.Companies.Company

  use InfoCnpjWeb, :live_view

  import HTTPoison
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
        data = get_company_from_api(cnpj)

        Companies.create_company(%Company{
          cnpj: cnpj,
          company_type: data.tipoEstabelecimento,
          country: data.endereco.pais.codigo,
          county: data.endereco.municipio.codigo,
          district: data.endereco.bairro,
          enterprise_name: data.nomeEmpresarial,
          fantasy_name: data.nomeFantasia,
          ni: data.ni,
          number: data.endereco.numero,
          opening_date: data.dataAbertura,
          phone_ddd: data.telefone.ddd,
          phone_number: data.telefone.numero,
          public_place: data.endereco.logradouro
        })

        {:noreply, assign(socket, :company, company)}
    end
  end

  defp get_cnpj_from_attrs(attrs) do
    attrs |> Map.get("cnpj")
  end

  defp get_company_from_api(cnpj) do
    case HTTPoison.get!(
           "https://h-apigateway.conectagov.estaleiro.serpro.gov.br/api-cnpj-empresa/v2/empresa/#{cnpj}"
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
