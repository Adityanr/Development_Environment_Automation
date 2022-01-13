## Parameters
param(
    # WebSite name
    [string]$WebsiteName,
    # Port binding info
    [string]$PortBindingInfo,
    # New Port number
    [int]$NewPortNumber
)

Set-WebBinding -Name $WebsiteName -BindingInformation $PortBindingInfo -PropertyName "Port" -Value $NewPortNumber