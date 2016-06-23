defmodule Riismi.Email do
  import Bamboo.Email

  def new_software_email(new_software_list) when is_list(new_software_list)  do
    head = ~s"<strong>New Software</strong><br />"
    table_head = ~s"""
    <table>
      <tr>
        <th>Machine</th>
        <th>Software Name</th>
        <th>Software Version</th>
      </tr>
    """
    body = Enum.reduce("", fn(new_software_record, accumulator) ->
      accumulator <> 
      """
      <tr>
        <td>#{new_software_record["machine_id"]}</td>
        <td>#{new_software_record["sw_name"]}</td>
        <td>#{new_software_record["sw_version"]}</td>
      </tr>
      """
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
