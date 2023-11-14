defmodule InfoCnpj.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset
  import Brcpfcnpj.Changeset

  schema "companies" do
    field :cep, :string
    field :cnpj, :string
    field :company_type, :string
    field :country, :string
    field :county, :string
    field :district, :string
    field :email, :string
    field :enterprise_name, :string
    field :fantasy_name, :string
    field :number, :string
    field :opening_date, :string
    field :phone_ddd, :string
    field :phone_number, :string
    field :public_place, :string
    field :public_place_type, :string
    field :state, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:cnpj, :cep, :company_type, :email, :enterprise_name, :fantasy_name, :opening_date, :country, :county, :district, :public_place, :number, :phone_ddd, :phone_number, :public_place_type, :state])
    |> validate_required([:cnpj, :cep, :company_type, :email, :enterprise_name, :fantasy_name, :opening_date, :country, :county, :district, :public_place, :number, :phone_ddd, :phone_number, :public_place_type, :state])
    |> validate_cnpj(:cnpj)
  end
end
