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
```txt
Name        col        col2         val   
----        ----       ----         ----  
あああああ  aaaあああ  12           1     
test        aaaa       1あああ4532  123   
あああああ  aaaあああ  12           1     
あああああ  aaaあああ  3333         1     
test        aaaa       1あああ4532  123   

Name        col        col2         val   
----        ----       ----         ----  
あああああ  aaaあああ  12           1     
test        aaaa       1あああ4532  123   
あああああ  aaaあああ  12           1     
あああああ  aaaあああ  3333         1     
test        aaaa       1あああ4532  123


## The result of "Format-Table" command ↓

Name  col    col2     val
----  ---    ----     ---
あああああ aaaあああ 12         1
test  aaaa   1あああ4532 123
あああああ aaaあああ 12         1
あああああ aaaあああ 3333       1
test  aaaa   1あああ4532 123

```
