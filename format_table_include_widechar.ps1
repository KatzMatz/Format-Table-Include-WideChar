function Format-Table-Include-WideChar {
    [OutputType([String])] 
    
    Param (
    [Parameter(ValueFromPipeline=$true, Mandatory=$true, Position=0)]
    $InputObject
    )
    
    begin {
        [PSCustomObject[]] $object = @()
        [int] $lengthObjectList = 0
        if ($InputObject.Count) {
            $object = $InputObject
            $lengthObjectList = $InputObject.Count
        }
    }
    
    process {
        
        if (!$InputObject.Count) {
            $object += $InputObject
            $lengthObjectList += 1   
        }    
        
    }
    
    end {

        function Padding-Space-In-Origin-Width {
            param (
            [string] $text,
            [int] $maxWidth
            )
            
            $resultText = $text
            
            $width = Get-Text-Width $text
            $currentWidth = $width
            
            while ($currentWidth -lt $maxWidth + 2) {
                $resultText += " "
                $currentWidth++
            }
            
            return $resultText
        }

        function Get-Max-Width{
            param (
            [PSCustomObject[]] $object,
            [String] $property
            )
            
            $maxWidth = 0
            
            for($idx=0;$idx -lt $object.Count;$idx++) {
                $width = Get-Text-Width $object[$idx].$property
                if ($maxWidth -lt $width) {
                    $maxWidth = $width
                }
            }
            
            $propertyLength = Get-Text-Width $property
            
            if ($maxWidth -lt $propertyLength) {
                $maxWidth = $propertyLength
            }
            
            if ($maxWidth -le 4) {
                return 4
            } else {
                return $maxWidth
            }
            
        }

        function Get-Text-Width {
            param (
            [String]$text
            )
            
            [int] $width = 0
            
            $utf8 = [System.Text.Encoding]::GetEncoding("UTF-8")
            for ($idx = 0; $idx -lt $text.Length; $idx++) {
                $byteLength = $utf8.GetByteCount($text[$idx])
                
                if ($byteLength -eq 1) {
                    $width += 1
                } else {
                    if ($text[$idx] -match "[\uFF61-\uFF9F+]") {
                        $width += 1
                    } else {
                        $width += 2
                    }
                }
            }
            return $width
        }


        [PSCustomObject[]] $propertyWidthList = @()
        $properties = $object[0].psobject.Properties.Name
        
        foreach ($prop in $properties) {
            $width = Get-Max-Width $object $prop
            
            $propertyWidthList += [PSCustomObject]@{
                property = $prop
                maxWidth = $width
            }
        }
        
        $lineText = ""
        foreach ($prop in $propertyWidthList) {
            $displayText = Padding-Space-In-Origin-Width $prop.property $prop.maxWidth
            $lineText += $displayText
        }
        
        $lineText
        $lineText = ""
        
        
        foreach ($prop in $propertyWidthList) {
            $displayText = Padding-Space-In-Origin-Width "----" $prop.maxWidth
            $lineText += $displayText
        }
        $lineText
        $lineText = ""
        
        
        # Output each line
        for ($idx = 0;$idx -lt $lengthObjectList;$idx++){
            foreach ($prop in $propertyWidthList) {
                $propText = [String]$object[$idx].($prop.property)
                $displayText = Padding-Space-In-Origin-Width $propText $prop.maxWidth
                # Write-Host $displayText -NoNewline
                $lineText += $displayText
            }
            
            # Write-Host ""
            $lineText
            $lineText = ""
        }
    }
    
}
