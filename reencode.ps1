$filename = @(Get-Item $args[0])
foreach($file in $filename)
{
    $base_file_name = $file.BaseName
    $file_extension = $file.Extension
    $old_name = -join($base_file_name,".cp1252",$file_extension)
    $new_name = -join($base_file_name,".utf8",$file_extension)

    cp $file $old_name
    gc $file | Out-File -en utf8 "$new_name"
}
