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

      _ ->
        data = get_company_from_api(cnpj)
        company = create_company_from_json(data, cnpj)

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
      %HTTPoison.Response{body: body, status_code: 200} ->
        {:ok, Jason.decode!(body)}

      %HTTPoison.Response{status_code: 404} ->
        {:error, :not_found}

      %HTTPoison.Error{reason: reason} ->
        {:error, reason}
    end
  end

  defp create_company_from_json(data, cnpj) do
    case data do
      {:ok, data} ->
        Companies.create_retrieved_company(%Company{
          cnpj: cnpj,
          company_type: Map.get(data, "estabelecimento", %{})["tipo"],
          country: Map.get(Map.get(data, "estabelecimento", %{}), "pais", %{})["nome"],
          county: Map.get(Map.get(data, "estabelecimento", %{}), "cidade", %{})["nome"],
          district: Map.get(data, ["estabelecimento"], %{})["bairro"],
          enterprise_name: data["razao_social"],
          fantasy_name: Map.get(data, ["estabelecimento"], %{})["nome_fantasia"],
          cep: Map.get(data, ["estabelecimento"], %{})["cep"],
          number: Map.get(data, ["estabelecimento"], %{})["numero"],
          opening_date: Map.get(data, ["estabelecimento"], %{})["data_inicio_atividade"],
          phone_ddd: Map.get(data, ["estabelecimento"], %{})["ddd1"],
          phone_number: Map.get(data, ["estabelecimento"], %{})["telefone1"],
          public_place: Map.get(data, ["estabelecimento"], %{})["logradouro"]
        })

      _ ->
        IO.puts("Invalid")
    end
  end
end
