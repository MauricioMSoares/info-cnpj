# InfoCnpj
Info CNPJ is a simple Elixir/Phoenix application developed to turn company information seeking process into an easy thing.
<br>
Having the CNPJ number in hands, get access to every detail on the company, enriching your lead's qualification.
<br>
<br>

## Setup
Info CNPJ runs in Elixir 1.15.7. Make sure you have this or any older versions installed, along with Erlang.
<br>
In order to store data, access "dev.exs" and configure your database. The default version is using PostgreSQL.
<br>
To run the server in localhost, run in your terminal

1. mix deps.get
2. mix phx.server

The server will be fired up on port 4000.

## External API
CNPJ.ws: https://www.cnpj.ws/
<br>
<br>

## Additional Dependencies
1. BR CPF CNPJ - brazilian documents' validation: https://hex.pm/packages/brcpfcnpj
2. HTTPoison - HTTP Requests: https://hex.pm/packages/httpoison
3. CSV - .csv file manipulation: https://hex.pm/packages/csv
<br>

## Plugin
VLibras - Brazilian signals language (consider using a Portuguese translated version of the page for compatibility): https://www.gov.br/governodigital/pt-br/vlibras