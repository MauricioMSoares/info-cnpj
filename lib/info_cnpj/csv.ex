defmodule InfoCnpj.Csv do
  alias InfoCnpj.Companies

  @doc """
  Generates a CSV file in /tmp directory, containing data of all companies in the database
  """
  def create_csv do
    fields = [
      :enterprise_name,
      :fantasy_name,
      :company_type,
      :country,
      :state,
      :county,
      :district,
      :public_place_type,
      :public_place,
      :number,
      :cep,
      :cnpj,
      :email,
      :phone_ddd,
      :phone_number,
      :opening_date
    ]

    csv_data = csv_content(Companies.list_companies(), fields)

    File.write("/tmp/companies.csv", csv_data)
    |> IO.inspect()

    IO.inspect(csv_data, label: "csv_data")
  end

  defp csv_content(records, fields) do
    records
    |> Enum.map(fn record ->
      record
      |> Map.from_struct()
      |> Map.take([])
      |> Map.merge(Map.take(record, fields))
      |> Map.values()
    end)
    |> CSV.encode(separator: ?, , delimiter: "\n")
    |> Enum.to_list()
    |> to_string()
  end
end
