defmodule InfoCnpjWeb.CompanyController do
  use InfoCnpjWeb, :controller

  alias InfoCnpj.Companies
  alias InfoCnpj.Companies.Company

  def index(conn, _params) do
    companies = Companies.list_companies()
    render(conn, :index, companies: companies)
  end

  def new(conn, _params) do
    changeset = Companies.change_company(%Company{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"company" => company}) do
    company = Companies.create_company_struct_from_json(company)

    case Companies.create_retrieved_company(company) do
      {:ok, _company} ->
        conn
        |> put_flash(:info, "Company created successfully.")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Companies.get_company!(id)
    render(conn, :show, company: company)
  end

  def edit(conn, %{"id" => id}) do
    company = Companies.get_company!(id)
    changeset = Companies.change_company(company)
    render(conn, :edit, company: company, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Companies.get_company!(id)

    case Companies.update_company(company, company_params) do
      {:ok, _company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, company: company, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Companies.get_company!(id)
    {:ok, _company} = Companies.delete_company(company)

    conn
    |> put_flash(:info, "Company deleted successfully.")
  end
end