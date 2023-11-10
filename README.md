# InfoCnpj
Info CNPJ is a simple Elixir/Phoenix application developed to turn company information seeking process into an easy thing.
<br>
Having the CNPJ number in hands, get access to every detail on the company, enriching your lead's qualification.
<br>

## External API
Consulta CNPJ: https://www.gov.br/conecta/catalogo/apis/consulta-cnpj
<br>

## Additional Dependencies
<br>
...

mix phx.gen.schema Company companies ni:string company_type:string enterprise_name:string fantasy_name:string opening_date:string country:string county:string district:string public_place:string number:string phone_ddd:string phone_number:string
mix phx.gen.context Companies Company companies ni:string company_type:string enterprise_name:string fantasy_name:string opening_date:string country:string county:string district:string public_place:string number:string phone_ddd:string phone_number:string