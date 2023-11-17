defmodule InfoCnpj.Companies do
  @moduledoc """
  The Companies context.
  """

  import Ecto.Query, warn: false
  alias InfoCnpj.Repo

  alias InfoCnpj.Companies.Company

  @doc """
  Returns the list of companies.

  ## Examples

      iex> list_companies()
      [%Company{}, ...]

  """
  def list_companies do
    Repo.all(Company)
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(123)
      %Company{}

      iex> get_company!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company!(id), do: Repo.get!(Company, id)

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(%{field: value})
      {:ok, %Company{}}

      iex> create_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{data: %Company{}}

  """
  def change_company(%Company{} = company, attrs \\ %{}) do
    Company.changeset(company, attrs)
  end

  @doc """
  Gets a single company by it's CNPJ.

  ## Examples

      iex> get_company_by_cnpj(12345678901234)
      %Company{}

  """
  def get_company_by_cnpj(cnpj) do
    Repo.get_by(Company, cnpj: cnpj)
  end

  @doc """
  Creates a company with data retrieved from the external API.

  ## Examples

      iex> create_retrieved_company(company)
      {:ok, %Company{}}

  """
  def create_retrieved_company(%Company{} = company) do
    company
    |> Repo.insert()
  end

  @doc """
  Creates a company struct using a JSON returned from the external API.

  ## Examples

      iex> create_company_struct_from_json(data)
      %Company{}

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
