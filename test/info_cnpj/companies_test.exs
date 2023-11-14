defmodule InfoCnpj.CompaniesTest do
  use InfoCnpj.DataCase

  alias InfoCnpj.Companies

  describe "companies" do
    alias InfoCnpj.Companies.Company

    import InfoCnpj.CompaniesFixtures

    @invalid_attrs %{cep: nil, cnpj: nil, company_type: nil, country: nil, county: nil, district: nil, email: nil, enterprise_name: nil, fantasy_name: nil, number: nil, opening_date: nil, phone_ddd: nil, phone_number: nil, public_place: nil, public_place_type: nil, state: nil}

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Companies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      valid_attrs = %{cep: "some cep", cnpj: "some cnpj", company_type: "some company_type", country: "some country", county: "some county", district: "some district", email: "some email", enterprise_name: "some enterprise_name", fantasy_name: "some fantasy_name", ni: "some ni", number: "some number", opening_date: "some opening_date", phone_ddd: "some phone_ddd", phone_number: "some phone_number", public_place: "some public_place", public_place_type: "some public_place_type", state: "some state"}

      assert {:ok, %Company{} = company} = Companies.create_company(valid_attrs)
      assert company.cep == "some cep"
      assert company.cnpj == "some cnpj"
      assert company.company_type == "some company_type"
      assert company.country == "some country"
      assert company.county == "some county"
      assert company.district == "some district"
      assert company.email == "some email"
      assert company.enterprise_name == "some enterprise_name"
      assert company.fantasy_name == "some fantasy_name"
      assert company.number == "some number"
      assert company.opening_date == "some opening_date"
      assert company.phone_ddd == "some phone_ddd"
      assert company.phone_number == "some phone_number"
      assert company.public_place == "some public_place"
      assert company.public_place_type == "some public_place_type"
      assert company.state == "some state"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      update_attrs = %{cep: "some cep", cnpj: "some cnpj", company_type: "some company_type", country: "some country", county: "some county", district: "some district", email: "some email", enterprise_name: "some enterprise_name", fantasy_name: "some fantasy_name", ni: "some ni", number: "some number", opening_date: "some opening_date", phone_ddd: "some phone_ddd", phone_number: "some phone_number", public_place: "some public_place", public_place_type: "some public_place_type", state: "some state"}

      assert {:ok, %Company{} = company} = Companies.update_company(company, update_attrs)
      assert company.cep == "some cep"
      assert company.cnpj == "some cnpj"
      assert company.company_type == "some company_type"
      assert company.country == "some country"
      assert company.county == "some county"
      assert company.district == "some district"
      assert company.email == "some email"
      assert company.enterprise_name == "some enterprise_name"
      assert company.fantasy_name == "some fantasy_name"
      assert company.number == "some number"
      assert company.opening_date == "some opening_date"
      assert company.phone_ddd == "some phone_ddd"
      assert company.phone_number == "some phone_number"
      assert company.public_place == "some public_place"
      assert company.public_place_type == "some public_place_type"
      assert company.state == "some state"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_company(company, @invalid_attrs)
      assert company == Companies.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Companies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Companies.change_company(company)
    end
  end

  describe "companies" do
    alias InfoCnpj.Companies.Company

    import InfoCnpj.CompaniesFixtures

    @invalid_attrs %{cep: nil, cnpj: nil, company_type: nil, country: nil, county: nil, district: nil, email: nil, enterprise_name: nil, fantasy_name: nil, ni: nil, number: nil, opening_date: nil, phone_ddd: nil, phone_number: nil, public_place: nil, public_place_type: nil, state: nil}

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Companies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      valid_attrs = %{cep: "some cep", cnpj: "some cnpj", company_type: "some company_type", country: "some country", county: "some county", district: "some district", email: "some email", enterprise_name: "some enterprise_name", fantasy_name: "some fantasy_name", ni: "some ni", number: "some number", opening_date: "some opening_date", phone_ddd: "some phone_ddd", phone_number: "some phone_number", public_place: "some public_place", public_place_type: "some public_place_type", state: "some state"}

      assert {:ok, %Company{} = company} = Companies.create_company(valid_attrs)
      assert company.cep == "some cep"
      assert company.cnpj == "some cnpj"
      assert company.company_type == "some company_type"
      assert company.country == "some country"
      assert company.county == "some county"
      assert company.district == "some district"
      assert company.email == "some email"
      assert company.enterprise_name == "some enterprise_name"
      assert company.fantasy_name == "some fantasy_name"
      assert company.number == "some number"
      assert company.opening_date == "some opening_date"
      assert company.phone_ddd == "some phone_ddd"
      assert company.phone_number == "some phone_number"
      assert company.public_place == "some public_place"
      assert company.public_place_type == "some public_place_type"
      assert company.state == "some state"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      update_attrs = %{cep: "some updated cep", cnpj: "some updated cnpj", company_type: "some updated company_type", country: "some updated country", county: "some updated county", district: "some updated district", email: "some updated email", enterprise_name: "some updated enterprise_name", fantasy_name: "some updated fantasy_name", number: "some updated number", opening_date: "some updated opening_date", phone_ddd: "some updated phone_ddd", phone_number: "some updated phone_number", public_place: "some updated public_place", public_place_type: "some updated public_place_type", state: "some updated state"}

      assert {:ok, %Company{} = company} = Companies.update_company(company, update_attrs)
      assert company.cep == "some updated cep"
      assert company.cnpj == "some updated cnpj"
      assert company.company_type == "some updated company_type"
      assert company.country == "some updated country"
      assert company.county == "some updated county"
      assert company.district == "some updated district"
      assert company.email == "some updated email"
      assert company.enterprise_name == "some updated enterprise_name"
      assert company.fantasy_name == "some updated fantasy_name"
      assert company.number == "some updated number"
      assert company.opening_date == "some updated opening_date"
      assert company.phone_ddd == "some updated phone_ddd"
      assert company.phone_number == "some updated phone_number"
      assert company.public_place == "some updated public_place"
      assert company.public_place_type == "some updated public_place_type"
      assert company.state == "some updated state"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_company(company, @invalid_attrs)
      assert company == Companies.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Companies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Companies.change_company(company)
    end
  end
end
