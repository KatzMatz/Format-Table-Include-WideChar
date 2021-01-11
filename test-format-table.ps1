. .\format_table_include_widechar.ps1

[PSCustomObject[]]$a = @()

$a += [PSCustomObject]@{
    Name = "あああああ"
    col = "aaaあああ"
    col2 = "12"
    val = 1
}

$a += [PSCustomObject]@{
    Name = "test"
    col = "aaaa"
    col2 = "1あああ4532"
    val = 123
}

$a += [PSCustomObject]@{
    Name = "あああああ"
    col = "aaaあああ"
    col2 = "12"
    val = 1
}
$a += [PSCustomObject]@{
    Name = "あああああ"
    col = "aaaあああ"
    col2 = "3333"
    val = 1
}

$a += [PSCustomObject]@{
    Name = "test"
    col = "aaaa"
    col2 = "1あああ4532"
    val = 123
}


# Format-Table-Include-WideChar $a | Out-File test.csv -Encoding utf8

$a | Format-Table-Include-WideChar
Write-Output ""
Format-Table-Include-WideChar -InputObject $a
Write-Output ""
Format-Table -InputObject $a