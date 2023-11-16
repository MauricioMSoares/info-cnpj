defmodule InfoCnpj.CompaniesTest do
  use InfoCnpj.DataCase

  alias InfoCnpj.Companies

  describe "companies" do
    alias InfoCnpj.Companies.Company

    import InfoCnpj.CompaniesFixtures

    @invalid_attrs %Company{cep: nil, cnpj: nil, company_type: nil, country: nil, county: nil, district: nil, email: nil, enterprise_name: nil, fantasy_name: nil, number: nil, opening_date: nil, phone_ddd: nil, phone_number: nil, public_place: nil, public_place_type: nil}

    test "create_retrieved_company/1 with valid data creates a company" do
      valid_attrs = %Company{cep: "some cep", cnpj: "some cnpj", company_type: "some company_type", country: "some country", county: "some county", district: "some district", email: "some email", enterprise_name: "some enterprise_name", fantasy_name: "some fantasy_name", number: "some number", opening_date: "some opening_date", phone_ddd: "some phone_ddd", phone_number: "some phone_number", public_place: "some public_place", public_place_type: "some public_place_type"}

      assert {:ok, %Company{} = company} = Companies.create_retrieved_company(valid_attrs)
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
    end
  end
end
