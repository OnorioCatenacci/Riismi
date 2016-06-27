defmodule Riismi.Email do
  import Bamboo.Email

  def new_software_email(new_software_list) when is_list(new_software_list)  do
    head = ~s(<h1 style="text-align: center;">New Software</h1><br />)
    table_head = ~s(
    <table style="border: 1px solid black; border-collapse: collapse;">
      <tr style="border: 1px solid black;">
        <th style="border: 1px solid black;">Machine</th>
        <th style="border: 1px solid black;">Software Name</th>
        <th style="border: 1px solid black;">Software Version</th>
      </tr>
    )
    body =
      new_software_list
      |> Enum.reduce("", fn(new_software_record, accumulator) ->
      %Riismi.Inventory{machine_id: m, sw_name: swn, sw_version: swv} = new_software_record
      accumulator <> 
      ~s(<tr style="border: 1px solid black;"><td style="border: 1px solid black;">#{m}</td><td style="border: 1px solid black;">#{swn}</td><td style="border: 1px solid black;">#{swv}</td></tr>)
    end)

    html_for_email = """
    #{head}
    #{table_head}
    #{body}
    """
    new_email
    |> to("ocatenacci@riis.com")
    |> from("ocatenacci@riis.com")
    |> subject("Newly Installed Software")
    |> html_body(html_for_email)
  end
end
