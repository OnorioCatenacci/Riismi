$filename = @(Get-Item $args[0])
Set-Variable -name crlf -option constant -value "`r`n"
Set-Variable -name double_crlf -option constant -value "$crlf$crlf"

foreach($file in $filename)
{
    $base_file_name = $file.BaseName
    $file_extension = $file.Extension
    $old_name = -join($base_file_name,".cp1252",$file_extension)
    $new_name = -join($base_file_name,".utf8",$file_extension)

    cp $file $old_name
    (gc $file -Raw).Replace($double_crlf,$crlf) | Out-File -en utf8 "$new_name"
    mv "$new_name" "$file" -force
}
