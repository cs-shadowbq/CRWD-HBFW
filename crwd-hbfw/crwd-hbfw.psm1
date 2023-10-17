# This needs to use my Stucture module. You can run a FWPM_CONDITION_IP_LOCAL_PORT query with the filter string.
# Only the ActionType will work like this. 

class CRWDFWFilter {
    # Optionally, add attributes to prevent invalid values
    [ValidateNotNullOrEmpty()][string]$Id
    [ValidateNotNullOrEmpty()][string]$ActionType
    [ValidateNotNullOrEmpty()][string]$EffectiveWeight
    [ValidateNotNullOrEmpty()][string]$RuleType
    $FWPM_CONDITION_ALE_APP_ID
    $FWPM_CONDITION_ALE_EFFECTIVE_NAME
    $FWPM_CONDITION_ALE_NAP_CONTEXT
    $FWPM_CONDITION_ALE_ORIGINAL_APP_ID
    $FWPM_CONDITION_ALE_PACKAGE_ID
    $FWPM_CONDITION_ALE_PROMISCUOUS_MODE
    $FWPM_CONDITION_ALE_REAUTH_REASON
    $FWPM_CONDITION_ALE_REMOTE_MACHINE_ID
    $FWPM_CONDITION_ALE_REMOTE_USER_ID
    $FWPM_CONDITION_ALE_SECURITY_ATTRIBUTE_FQBN_VALUE
    $FWPM_CONDITION_ALE_SIO_FIREWALL_SYSTEM_PORT
    $FWPM_CONDITION_ALE_USER_ID
    $FWPM_CONDITION_ARRIVAL_INTERFACE_INDEX
    $FWPM_CONDITION_ARRIVAL_INTERFACE_PROFILE_ID
    $FWPM_CONDITION_ARRIVAL_INTERFACE_TYPE
    $FWPM_CONDITION_ARRIVAL_TUNNEL_TYPE
    $FWPM_CONDITION_AUTHENTICATION_TYPE
    $FWPM_CONDITION_CLIENT_CERT_KEY_LENGTH
    $FWPM_CONDITION_CLIENT_CERT_OID
    $FWPM_CONDITION_CLIENT_TOKEN
    $FWPM_CONDITION_COMPARTMENT_ID
    $FWPM_CONDITION_CURRENT_PROFILE_ID
    $FWPM_CONDITION_DCOM_APP_ID
    $FWPM_CONDITION_DESTINATION_INTERFACE_INDEX
    $FWPM_CONDITION_DESTINATION_SUB_INTERFACE_INDEX
    $FWPM_CONDITION_DIRECTION
    $FWPM_CONDITION_EMBEDDED_LOCAL_ADDRESS_TYPE
    $FWPM_CONDITION_EMBEDDED_LOCAL_PORT
    $FWPM_CONDITION_EMBEDDED_PROTOCOL
    $FWPM_CONDITION_EMBEDDED_REMOTE_ADDRESS
    $FWPM_CONDITION_EMBEDDED_REMOTE_PORT
    $FWPM_CONDITION_ETHER_TYPE
    $FWPM_CONDITION_FLAGS
    $FWPM_CONDITION_IMAGE_NAME
    $FWPM_CONDITION_INTERFACE_INDEX
    $FWPM_CONDITION_INTERFACE_MAC_ADDRESS
    $FWPM_CONDITION_INTERFACE_QUARANTINE_EPOCH
    $FWPM_CONDITION_INTERFACE_TYPE
    $FWPM_CONDITION_IPSEC_POLICY_KEY
    $FWPM_CONDITION_IPSEC_SECURITY_REALM_ID
    $FWPM_CONDITION_IP_ARRIVAL_INTERFACE
    $FWPM_CONDITION_IP_DESTINATION_ADDRESS
    $FWPM_CONDITION_IP_DESTINATION_ADDRESS_TYPE
    $FWPM_CONDITION_IP_DESTINATION_PORT
    $FWPM_CONDITION_IP_FORWARD_INTERFACE
    $FWPM_CONDITION_IP_LOCAL_ADDRESS
    $FWPM_CONDITION_IP_LOCAL_ADDRESS_TYPE
    $FWPM_CONDITION_IP_LOCAL_ADDRESS_V4
    $cIP_LOCAL_ADDRESS_V6
    $FWPM_CONDITION_IP_LOCAL_INTERFACE
    $FWPM_CONDITION_IP_LOCAL_PORT
    $FWPM_CONDITION_IP_NEXTHOP_ADDRESS
    $FWPM_CONDITION_IP_NEXTHOP_INTERFACE
    $FWPM_CONDITION_IP_PHYSICAL_ARRIVAL_INTERFACE
    $FWPM_CONDITION_IP_PHYSICAL_NEXTHOP_INTERFACE
    $FWPM_CONDITION_IP_PROTOCOL
    $FWPM_CONDITION_IP_REMOTE_ADDRESS
    $FWPM_CONDITION_IP_REMOTE_ADDRESS_V4
    $FWPM_CONDITION_IP_REMOTE_ADDRESS_V6
    $FWPM_CONDITION_IP_REMOTE_PORT
    $FWPM_CONDITION_IP_SOURCE_ADDRESS
    $FWPM_CONDITION_IP_SOURCE_PORT
    $FWPM_CONDITION_KM_AUTH_NAP_CONTEXT
    $FWPM_CONDITION_KM_MODE
    $FWPM_CONDITION_KM_TYPE
    $FWPM_CONDITION_L2_FLAGS
    $FWPM_CONDITION_LOCAL_INTERFACE_PROFILE_ID
    $FWPM_CONDITION_MAC_DESTINATION_ADDRESS
    $FWPM_CONDITION_MAC_DESTINATION_ADDRESS_TYPE
    $FWPM_CONDITION_MAC_LOCAL_ADDRESS
    $FWPM_CONDITION_MAC_LOCAL_ADDRESS_TYPE
    $FWPM_CONDITION_MAC_REMOTE_ADDRESS
    $FWPM_CONDITION_MAC_REMOTE_ADDRESS_TYPE
    $FWPM_CONDITION_MAC_SOURCE_ADDRESS
    $FWPM_CONDITION_MAC_SOURCE_ADDRESS_TYPE
    $FWPM_CONDITION_NDIS_MEDIA_TYPE
    $FWPM_CONDITION_NDIS_PHYSICAL_MEDIA_TYPE
    $FWPM_CONDITION_NDIS_PORT
    $FWPM_CONDITION_NET_EVENT_TYPE
    $FWPM_CONDITION_NEXTHOP_INTERFACE_INDEX
    $FWPM_CONDITION_NEXTHOP_INTERFACE_PROFILE_ID
    $FWPM_CONDITION_NEXTHOP_INTERFACE_TYPE
    $FWPM_CONDITION_NEXTHOP_SUB_INTERFACE_INDEX
    $FWPM_CONDITION_NEXTHOP_TUNNEL_TYPE
    $FWPM_CONDITION_ORIGINAL_ICMP_TYPE
    $FWPM_CONDITION_ORIGINAL_PROFILE_ID
    $FWPM_CONDITION_PEER_NAME
    $FWPM_CONDITION_PIPE
    $FWPM_CONDITION_PROCESS_WITH_RPC_IF_UUID
    $FWPM_CONDITION_QM_MODE
    $FWPM_CONDITION_REAUTHORIZE_REASON
    $FWPM_CONDITION_REMOTE_ID
    $FWPM_CONDITION_REMOTE_USER_TOKEN
    $FWPM_CONDITION_RESERVED0
    $FWPM_CONDITION_RESERVED1
    $FWPM_CONDITION_RESERVED10
    $FWPM_CONDITION_RESERVED11
    $FWPM_CONDITION_RESERVED12
    $FWPM_CONDITION_RESERVED13
    $FWPM_CONDITION_RESERVED14
    $FWPM_CONDITION_RESERVED15
    $FWPM_CONDITION_RESERVED2
    $FWPM_CONDITION_RESERVED3
    $FWPM_CONDITION_RESERVED4
    $FWPM_CONDITION_RESERVED5
    $FWPM_CONDITION_RESERVED6
    $FWPM_CONDITION_RESERVED7
    $FWPM_CONDITION_RESERVED8
    $FWPM_CONDITION_RESERVED9
    $FWPM_CONDITION_RPC_AUTH_LEVEL
    $FWPM_CONDITION_RPC_AUTH_TYPE
    $FWPM_CONDITION_RPC_EP_FLAGS
    $FWPM_CONDITION_RPC_EP_VALUE
    $FWPM_CONDITION_RPC_IF_FLAG
    $FWPM_CONDITION_RPC_IF_UUID
    $FWPM_CONDITION_RPC_IF_VERSION
    $FWPM_CONDITION_RPC_PROTOCOL
    $FWPM_CONDITION_RPC_PROXY_AUTH_TYPE
    $FWPM_CONDITION_RPC_SERVER_NAME
    $FWPM_CONDITION_RPC_SERVER_PORT
    $FWPM_CONDITION_SEC_ENCRYPT_ALGORITHM
    $FWPM_CONDITION_SEC_KEY_SIZE
    $FWPM_CONDITION_SOURCE_INTERFACE_INDEX
    $FWPM_CONDITION_SOURCE_SUB_INTERFACE_INDEX
    $FWPM_CONDITION_SUB_INTERFACE_INDEX
    $FWPM_CONDITION_TUNNEL_TYPE
    $FWPM_CONDITION_VLAN_ID
    $FWPM_CONDITION_VSWITCH_DESTINATION_INTERFACE_ID
    $FWPM_CONDITION_VSWITCH_DESTINATION_INTERFACE_TYPE
    $FWPM_CONDITION_VSWITCH_DESTINATION_VM_ID
    $FWPM_CONDITION_VSWITCH_ID
    $FWPM_CONDITION_VSWITCH_NETWORK_TYPE
    $FWPM_CONDITION_VSWITCH_SOURCE_INTERFACE_ID
    $FWPM_CONDITION_VSWITCH_SOURCE_INTERFACE_TYPE
    $FWPM_CONDITION_VSWITCH_SOURCE_VM_ID
    $FWPM_CONDITION_VSWITCH_TENANT_NETWORK_ID
    $FWPM_CONNECTION_ENUM_FLAG_QUERY_BYTES_TRANSFERRED
    $FWPM_CONNECTION_EVENT_ADD
    $FWPM_CONNECTION_EVENT_DELETE
    $FWPM_CONNECTION_EVENT_MAX
}

function Test-isIPv4([System.Net.IPAddress]$addr) {
    return ($addr.AddressFamily -eq [System.Net.Sockets.AddressFamily]::InterNetwork)
}    

function Test-isIPv6([System.Net.IPAddress]$addr) {
    return ($addr.AddressFamily -eq [System.Net.Sockets.AddressFamily]::InterNetworkV6)
}

function Test-Command($cmdname)
{
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

function Get-StagedWFPFilter {
    param(
        [Parameter(Mandatory = $false)]
        [string]$ActionType = '',
        [string]$Id = '',
        [string]$RuleType = '[default]'
    )
    

    #If Id is not null then set RuleType to empty string if RuleType is default
    if ($Id) {
        if ($RuleType -eq '[default]') {
            $RuleType = ''
        }
    }

    # If RuleType is default then set RuleType to 'Persistent, Indexed'
    if ($RuleType -eq '[default]') {
        $RuleType = 'Persistent, Indexed'
    }

    # If DEBUG is set then write parameters to console
    If ($PSBoundParameters['Debug']) {
        write-host "[debug] Get-StagedWFPFilter"
        write-host "[debug] ------------------"
        write-host "[debug] ActionType: $ActionType"
        write-host "[debug] Id: $Id"
        write-host "[debug] RuleType: $RuleType"
        write-host "[debug] ------------------"
    }
    
    $filterstring = ''


    # Validate ActionType: ActionType must be either 'Permit' or 'Block'
    $ActionTypeC = $ActionType.ToUpper()
    if (($ActionTypeC -eq 'PERMIT') -or ($ActionTypeC -eq 'BLOCK')) { 
        $filterstring = $filterstring + ' -AND ($_.ActionType -eq ' + "'" + $ActionType + "')"
    }
    elseif ($ActionTypeC -eq '') {
    }
    else {
        # Debug: Write invalid RuleType to console
        Write-Output "** Invalid ActionType: $RuleType"
        Write-Output "** ActionType must be either 'Permit' or 'Block'"
        return
    }


    if ($Id) {
        $filterstring = $filterstring + ' -AND ($_.FilterId -eq ' + "'" + $Id + "')"
    }

    # Validate RuleType: RuleType must be either 'Persistent, Indexed' or 'BootTime, Indexed'
    $RuleTypeC = $RuleType.ToUpper()
    if (($RuleTypeC -eq 'PERSISTENT, INDEXED') -or ($RuleTypeC -eq 'BOOTTIME, INDEXED')) { 
        $filterstring = $filterstring + ' -AND ($_.Flags -eq ' + "'" + $RuleType + "')"
    }
    elseif ($RuleTypeC -eq '') {
    }
    else {
        # Debug: Write invalid RuleType to console
        Write-Output "** Invalid RuleType: $RuleType"
        Write-Output "** RuleType must be either '(0x41) Persistent, Indexed' or '(0x42) BootTime, Indexed'"
        return
    }

    # Build filterstring for Get-FwFilter
    #$filterstring = '{($_.Name -EQ "CrowdStrike WFP Filter")' + $filterstring + '}'
    $filterstring = '($_.Name -EQ "CrowdStrike WFP Filter")' + $filterstring + ''
    
    # Debug: Write filterstring to console
    If ($PSBoundParameters['Debug']) {
        write-host "[debug] Get-StagedWFPFilter ** filterstring: $filterstring"
    }
    

    $fsb = [scriptblock]::Create($filterstring)
    $FF = @()
    foreach ($f in (Get-FwFilter | Where-Object -FilterScript $fsb)) { 
        $E = [CRWDFWFilter]::new()
        $E.Id = "$($f.FilterId)"
        $E.ActionType = "$($f.ActionType)"
        $E.EffectiveWeight = "$($f.EffectiveWeight)"
        $E.RuleType = "$($f.flags)"
        foreach ($c in $f.Conditions) {
            $check = [string]$c.MatchType
            if ($check -eq 'Equal') {
                $E.$($c.FieldKeyName) = [string]$c.Value
            }
            else {
                $E.$($c.FieldKeyName) = [string]$c.MatchType + ':' + [string]$c.Value
            }
        }
        $FF += $E
    }
    return $FF
}

function Get-CrwdHbfw {
    <#
    .SYNOPSIS
    Display current CrowdStrike HostBased Firewall filters based on the Windows filter Platform(WFP).

    .DESCRIPTION
    The Get-CrwdHbfw function displays current CrowdStrike HostBased Firewall filters based on the Windows filter Platform(WFP).
    Get-CrwdHbfw outputs a list of CRWDFWFilter objects.
    CRWDFWFilter objects are custom objects that contain the following properties:
    Id, ActionType, EffectiveWeight, RuleType, FWPM_CONDITION_*.

    .PARAMETER ActionType
    The ActionType parameter specifies the action type of the WFP filter.
    The ActionType parameter must be either 'Permit' or 'Block'.

    .PARAMETER LPort
    The LPort parameter specifies the local port of the WFP filter.

    .PARAMETER RPort
    The RPort parameter specifies the remote port of the WFP filter.

    .PARAMETER LIP
    The LIP parameter specifies the local IP address of the WFP filter.

    .PARAMETER RIP
    The RIP parameter specifies the remote IP address of the WFP filter.

    .PARAMETER Protocol
    The Protocol parameter specifies the protocol of the WFP filter.

    .PARAMETER AppId
    The AppId parameter specifies the AppId of the WFP filter.

    .PARAMETER Id
    The Id parameter specifies the Id / FilterId of the WFP filter.

    .PARAMETER RuleType
    The RuleType parameter specifies the RuleType of the WFP filter.
    The RuleType parameter must be either 'Persistent, Indexed' or 'BootTime, Indexed'.

    .EXAMPLE
    PS> Get-CrwdHbfw -ActionType 'Permit' -LPort 3389

    .EXAMPLE
    PS> Get-CrwdHbfw -ActionType 'Block' -LPort 50000

    .EXAMPLE
    PS> Get-CrwdHbfw -ActionType 'Block' -RPort 22 -RIP 10.0.0.0/8

#>      
    param(
        [Parameter(Mandatory = $false)]
        [string]$ActionType = '',
        [string]$Id = '',
        [string]$RuleType = '[default]',
        [string]$LPort = '',
        [string]$RPort = '',
        [string]$LIP = '',
        [string]$RIP = '',
        [string]$Protocol = '',
        [string]$AppId = ''
    )

    if (Test-Command -cmdname 'Get-FwFilter' -ne $true) {
        Throw "Missing Required PowerShell Module 'NtObjectManager', with Cmdlet 'Get-FwFilter'"
    }


    $ParamHash = [ordered]@{
        ActionType = $ActionType;
        Id         = $Id;
        RuleType   = $RuleType
    }
    # If DEBUG is set then write paramhash to console
    If ($PSBoundParameters['Debug']) {
        write-host "[debug] Get-CrwdHbfw ** ParamHash:"
        write-host "[debug] ------------------"
        $ParamHash | ConvertTo-Json
        write-host "[debug] ------------------"
    }
    
    # Build filterstring for Get-FwFilter
    
    $N2Fstring = ''
    
    if ($LPort) {
        $N2Fstring = $N2Fstring + ' ($_.FWPM_CONDITION_IP_LOCAL_PORT -EQ ' + "'" + $LPort + "')"
    }

    if ($RPort) {
        if ($N2Fstring -NE '') { $N2Fstring = $N2Fstring + ' -AND' }
        $N2Fstring = $N2Fstring + ' ($_.FWPM_CONDITION_IP_REMOTE_PORT -EQ ' + "'" + $RPort + "')"
    }

    if ($LIP) {
        if ($N2Fstring -NE '') { $N2Fstring = $N2Fstring + ' -AND' }
        $N2Fstring = $N2Fstring + ' ($_.FWPM_CONDITION_IP_LOCAL_ADDRESS -EQ ' + "'" + $LIP + "')"
    }

    if ($RIP) {
        if ($N2Fstring -NE '') { $N2Fstring = $N2Fstring + ' -AND' }
        $N2Fstring = $N2Fstring + ' ($_.FWPM_CONDITION_IP_REMOTE_ADDRESS -EQ ' + "'" + $RIP + "')"
    }

    if ($Protocol) {
        if ($N2Fstring -NE '') { $N2Fstring = $N2Fstring + ' -AND' }
        $N2Fstring = $N2Fstring + ' ($_.FWPM_CONDITION_IP_PROTOCOL -EQ ' + "'" + $Protocol + "')"
    }

    if ($AppId) {
        if ($N2Fstring -NE '') { $N2Fstring = $N2Fstring + ' -AND' }
        $N2Fstring = $N2Fstring + ' ($_.FWPM_CONDITION_ALE_APP_ID -EQ ' + "'" + $AppId + "')"
    }

    # if Debug Print N2Fstring to console
    If ($PSBoundParameters['Debug']) {
        write-host "[debug] Get-CrwdHbfw ** W-O N2Fstring:"
        write-host "[debug] ------------------"
        write-host "[debug] $N2Fstring"
        write-host "[debug] ------------------"
    }

    $N2fsb = [scriptblock]::Create($N2Fstring)
    
    if ($N2Fstring -EQ '') {
        If ($PSBoundParameters['Debug']) {
            Get-StagedWFPFilter @ParamHash -Debug
        }
        else {
            Get-StagedWFPFilter @ParamHash
        }
    }
    else {
        If ($PSBoundParameters['Debug']) {
            Get-StagedWFPFilter @ParamHash -Debug | Where-Object -FilterScript $N2fsb
        }
        else {
            Get-StagedWFPFilter @ParamHash | Where-Object -FilterScript $N2fsb
        }
    }

}

function Format-CrwdHbfw {
    param(
        [Parameter(Mandatory = $True, ValuefromPipeline = $True)]
        [CRWDFWFilter[]]$Filter
    )
    if ($input.Count -gt 1) {
        # ForEach i in $input { Format-CrwdHbfw $i }
        $input | % { Format-CrwdHbfw $_ }
        
    } 
    else {
        # Print the object and all its properties if the property is not null
    

        $Filter | Get-Member -MemberType Property | Sort-Object -Property Definition | % { 
            if ($Filter.$($_.Name)) {
                if ($_.Name -eq 'Id') {
                    # convert Id of type int to hex string
                    Write-Output "Id: $($Filter.Id) [HEX: 0x$(([int32]$Filter.Id).ToString('X'))]"
                }
                else {
                    Write-Output "$($_.Name): $($Filter.$($_.Name))" 
                }
            
            } 
        }
        Write-Output ""
    }
}
