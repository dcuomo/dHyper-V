function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.Boolean]
        $RenameEnabled
    )

    $NetAdapterwithDeviceNaming = Get-NetAdapterAdvancedProperty | ? { $_.DisplayName -like "Hyper-V Net*" -and $_.DisplayValue -ne ''  }

    $returnValue = @{
        RenameEnabled              = $RenameEnabled
        NetAdapterwithDeviceNaming = $NetAdapterwithDeviceNaming
    }

    $returnValue
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.Boolean]
        $RenameEnabled
    )
    
    if ( $RenameEnabled ) {
        $Got = Get-TargetResource -RenameEnabled $RenameEnabled

        $Got.NetAdapterwithDeviceNaming | ForEach-Object {
            if   ( $_.Name -ne $_.DisplayValue ) {
                Rename-NetAdapter -Name $_.Name -NewName $_.DisplayValue
            }
        }
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.Boolean]
        $RenameEnabled
    )
    
    if ( $RenameEnabled ) {
        $Got = Get-TargetResource -RenameEnabled $RenameEnabled

        $Got.NetAdapterwithDeviceNaming | ForEach-Object {
            if   ( $_.Name -eq $_.DisplayValue ) { Return $true }
            Else { Return $false }
        }
    }
}

Export-ModuleMember -Function *-TargetResource
