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
        data = get_company_from_api(cnpj)
        company = create_company_struct_from_json(data)
        Companies.create_retrieved_company(company)

        IO.inspect("Trouxe de lá da API")
        IO.inspect(company)

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
    end
  end

  defp create_company_struct_from_json(data) do
    case data do
      {:ok, data} ->
        %Company{
          cep: access_estabelecimento(data)["cep"],
          cnpj: access_estabelecimento(data)["cnpj"],
          company_type: access_estabelecimento(data)["tipo"],
          country: Map.get(access_estabelecimento(data), "pais", %{})["nome"],
          county: Map.get(access_estabelecimento(data), "cidade", %{})["nome"],
          district: access_estabelecimento(data)["bairro"],
          email: access_estabelecimento(data)["email"],
          enterprise_name: data["razao_social"],
          fantasy_name: access_estabelecimento(data)["nome_fantasia"],
          number: access_estabelecimento(data)["numero"],
          opening_date: access_estabelecimento(data)["data_inicio_atividade"],
          phone_ddd: access_estabelecimento(data)["ddd1"],
          phone_number: access_estabelecimento(data)["telefone1"],
          public_place: access_estabelecimento(data)["logradouro"],
          public_place_type: access_estabelecimento(data)["tipo_logradouro"],
          state: Map.get(access_estabelecimento(data), "estado", %{})["nome"]
        }

      _ ->
        IO.puts("An error occurred while attempting to create company struct.")
    end
  end

  defp access_estabelecimento(json) do
    Map.get(json, "estabelecimento", %{})
  end

  @cnpj_regex ~r/(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/

  def extract_cnpj_number(cnpj) do
    case Regex.match?(@cnpj_regex, cnpj) do
      true ->
        Regex.replace(@cnpj_regex, cnpj, "\\1\\2\\3\\4\\5")

      false ->
        nil
    end
  end
end
