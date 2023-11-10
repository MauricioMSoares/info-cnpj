defmodule InfoCnpj.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset
  import Brcpfcnpj.Changeset

  schema "companies" do
    field :cnpj, :string
    field :company_type, :string
    field :country, :string
    field :county, :string
    field :district, :string
    field :enterprise_name, :string
    field :fantasy_name, :string
    field :ni, :string
    field :number, :string
    field :opening_date, :string
    field :phone_ddd, :string
    field :phone_number, :string
    field :public_place, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:cnpj, :ni, :company_type, :enterprise_name, :fantasy_name, :opening_date, :country, :county, :district, :public_place, :number, :phone_ddd, :phone_number])
    |> validate_required([:cnpj, :ni, :company_type, :enterprise_name, :fantasy_name, :opening_date, :country, :county, :district, :public_place, :number, :phone_ddd, :phone_number])
    |> validate_cnpj(:cnpj)
  end
end
