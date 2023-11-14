defmodule InfoCnpj.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :cnpj, :string
      add :cep, :string
      add :company_type, :string
      add :enterprise_name, :string
      add :fantasy_name, :string
      add :opening_date, :string
      add :country, :string
      add :county, :string
      add :district, :string
      add :public_place, :string
      add :number, :string
      add :phone_ddd, :string
      add :phone_number, :string

      timestamps(type: :utc_datetime)
    end
  end
end
