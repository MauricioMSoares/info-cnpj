# Info CNPJ
Info CNPJ is a simple Elixir/Phoenix application developed to turn company information seeking process into an easy thing.
<br>
Having the CNPJ number in hands, get access to every detail on the company, enriching your lead's qualification.
<br>
<br>

## Setup
Info CNPJ runs in Elixir 1.15.7. Make sure you have this or any older versions installed, along with Erlang.
<br>
In order to store data locally, access "dev.exs" and configure your database. The default database is using PostgreSQL.
<br>
To run the server in localhost, run in your terminal:

1. mix deps.get
2. mix phx.server

The server will be fired up on port 4000.
<br>
<br>

## How to use
1. To have access to the CNPJ finder and CSV exporter, you must first register with an example e-mail address and a password containing 12 or more characters;
2. After signing in, click on "Get Started!" or type "/verify-cnpj" in the URL to be redirected to the page;
3. You may type the CNPJ with or without masks. After a valid CNPJ has been typed, the "Verify" button will become available;
4. Click it and let the query run. If the company already exists in the database, it will be retrieved from there. Else, the external API will bring it and we save it right away. The data will be shown right below the button;
5. In order to export data of every company in your local database, click the "Export" button, on the bottom-right side of the page;
6. Look for "companies.csv" inside your "/tmp" directory.
<br>

## External API
CNPJ.ws: https://www.cnpj.ws/
<br>
<br>

## Additional Dependencies
1. <b>BR CPF CNPJ</b> - brazilian documents' validation: https://hex.pm/packages/brcpfcnpj
2. <b>HTTPoison</b> - HTTP Requests: https://hex.pm/packages/httpoison
3. <b>CSV</b> - .csv file manipulation: https://hex.pm/packages/csv
<br>

## Plugin
VLibras - Brazilian signals language (consider using a Portuguese translated version of the page for compatibility): https://www.gov.br/governodigital/pt-br/vlibras
