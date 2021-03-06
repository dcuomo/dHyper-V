function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $VMName
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    <#
    $returnValue = @{
    VMName = [System.String]
    NetAdapter = [System.String]
    Enabled = [System.String]
    }

    $returnValue
    #>
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $VMName,

        [System.String]
        $NetAdapter,

        [ValidateSet("On","Off")]
        [System.String]
        $Enabled
    )

    Set-VMNetworkAdapter -VMName $VMName -DeviceNaming $Enabled
    
    Get-VMNetworkAdapter -VMName $VMName | ForEach-Object {
        Rename-VMNetworkAdapter -VMNetworkAdapter $_ -NewName $_.SwitchName
    }
}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $VMName,

        [System.String]
        $NetAdapter,

        [ValidateSet("On","Off")]
        [System.String]
        $Enabled
    )

    $result = $false
    
    $result
}


Export-ModuleMember -Function *-TargetResource

