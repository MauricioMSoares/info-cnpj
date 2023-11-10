defmodule InfoCnpj.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
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
    |> cast(attrs, [:ni, :company_type, :enterprise_name, :fantasy_name, :opening_date, :country, :county, :district, :public_place, :number, :phone_ddd, :phone_number])
    |> validate_required([:ni, :company_type, :enterprise_name, :fantasy_name, :opening_date, :country, :county, :district, :public_place, :number, :phone_ddd, :phone_number])
  end
end
