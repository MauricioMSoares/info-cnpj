defmodule InfoCnpj.CompaniesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `InfoCnpj.Companies` context.
  """

  @doc """
  Generate a company.
  """
  def company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> Enum.into(%{
        company_type: "some company_type",
        country: "some country",
        county: "some county",
        district: "some district",
        enterprise_name: "some enterprise_name",
        fantasy_name: "some fantasy_name",
        ni: "some ni",
        number: "some number",
        opening_date: "some opening_date",
        phone_ddd: "some phone_ddd",
        phone_number: "some phone_number",
        public_place: "some public_place"
      })
      |> InfoCnpj.Companies.create_company()

    company
  end
end
