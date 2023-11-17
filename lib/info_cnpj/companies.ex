defmodule InfoCnpj.Companies do
  @moduledoc """
  The Companies context.
  """

  import Ecto.Query, warn: false
  alias InfoCnpj.Repo

  alias InfoCnpj.Companies.Company

  def list_companies do
    Repo.all(Company)
  end

  def get_company!(id), do: Repo.get!(Company, id)

  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  def change_company(%Company{} = company, attrs \\ %{}) do
    Company.changeset(company, attrs)
  end

  @doc """
  Gets a single company by it's CNPJ.

  ## Examples

      iex> company = InfoCnpj.Companies.get_company_by_cnpj("12345678901234")
      company

  """
  def get_company_by_cnpj(cnpj) do
    Repo.get_by(Company, cnpj: cnpj)
  end

  @doc """
  Creates a company with data retrieved from the external API.

  ## Examples

      iex> company = InfoCnpj.Companies.create_retrieved_company(%InfoCnpj.Companies.Company{})
      company

  """
  def create_retrieved_company(%Company{} = company) do
    company
    |> Repo.insert()
  end

  @doc """
  Creates a company struct using a JSON returned from the external API.

  ## Examples

      iex> struct = InfoCnpj.Companies.create_company_struct_from_json(%{})
      :ok

  """
  def create_company_struct_from_json(data) do
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
end
