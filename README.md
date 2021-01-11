# Format-Table-Include-WideChar
Powershell function to display a table (like "Format-Table" command) without broken format even if it contains multi-byte characters .

## How to use


### Command
```powershell
[PSCustomObject[]] $customObject

$customObject | Format-Table-Include-WideChar
# or
Format-Table-Include-WideChar $customObject
```

### Result

![Result image](/format-table-result.png)
