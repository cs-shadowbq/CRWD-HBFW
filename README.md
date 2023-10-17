# CRWD-HBFW

CrowdStrike Powershell module for parsing WFP for Falcon Host Based Firewall

## BackGround

CRWD-HBFW is a light-weight, powershell module that helps you debug and analyze the Windows Filtering Platform in the context of the CrowdStrike Falcon HostBased Firewall.

CrowdStrike Falcon's Host-based firewall is a module from the CrowdStrike Endpoint Protection Platform. It is enabled through the cs-agent located on the endpoint, and controlled through a channel file delivered to the endpoint.

CrowdStrike Firewall can have many network locations, and the agent will remove or add WFP filters based on the network location which is currently active.

This PS module is designed to help understand the current WFP active filters on a Windows Host with CrowdStrikes Falcon HostBased Firewall enabled.

*Note:* _CRWD-HBFW_ utilizes [NtObjectManager](https://github.com/googleprojectzero/sandbox-attacksurface-analysis-tools/tree/main/NtObjectManager) to access the WFP APIs. This module adds a provider and cmdlets to access the NT object manager namespace. 

## Quick Start

PowerShell install new modules from the public PSGallery repository

```powershell
Get-PSRepository
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
```

To install, run the following from an elevated powershell shell:

```powershell
#Install-Module NtObjectManager
Install-Module -Name NtObjectManager -RequiredVersion 2.0.0
Install-Module crwd-hbfw
```

Now the `Get-CrwdHbfw` command should be available.

You can validate and get more info via the help command:

```powershell
Get-Help Get-CrwdHbfw
```

## Notes on Security

You must use an * elevated rights (Run as Administrator)* powershell session: 

```powershell
PS > Get-CrwdHbfw
Get-FwFilter : Exception calling "EnumerateFilters" with "0" argument(s): "(0x80070005) - Access is denied."
At C:\Users\xxxx\Documents\WindowsPowerShell\Modules\crwd-hbfw\crwd-hbfw.psm1:242 char:21
+     foreach ($f in (Get-FwFilter | Where-Object -FilterScript $fsb))  ...
+                     ~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
    + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,Get-FwFilter
```

_Note_: MS Defender may alert on `NtObjectManager 1.x` - [create exclusion](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/configure-extension-file-exclusions-microsoft-defender-antivirus?view=o365-worldwide) for the module. It is recommended to use `NtObjectManager 2.x`, as stated in the installation.

## Usage

`Get-CrwdHbfw` is the main function of the module. It is a wrapper for `Get-FwFilter` from [NtObjectManager] and its output is filtered by `Get-CrwdHbfw` to only show the filters that are relevant to CrowdStrike HostBased Firewalls implemented by WFP.

Provided Benefits:

- CRWDFWFilter objects are returned
- You can use `Format-Table`, `Format-Wide`, `Format-List`, `Format-Custom` or `Format-CrwdHbfw` to format the output
- You can use `Where-Object`, and `Sort-Object` to filter the output
- `Details` is a META property that contains the details of the FWPM_Condition filter in a human readable format when using `Format-Table`.

```powershell
PS > Get-N2 -ActionType 'Permit' -LPort 3389 -Protocol Tcp | Format-Table                                                                                                      [debug] Get-N2 ** ParamHash:

Rule Type            Action Type          Id                   Details
---------            -----------          --                   -------
Persistent, Indexed  Permit               110555               FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 3389|IP_PROTOCOL: Tcp|
```

```powershell
> Get-CRWDFwFilter -ActionType 'Permit' -LPort 3389 | Sort-Object | Format-Table
Rule Type            Action Type          Id                   Details
---------            -----------          --                   -------
Persistent, Indexed  Permit               110507               FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 3389|IP_PROTOCOL: Udp|
Persistent, Indexed  Permit               110555               FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 3389|IP_PROTOCOL: Tcp|
```

Slice an Array of `CRWDFWFilter`

```powershell
PS > (Get-CRWDFwFilter -ActionType 'Permit')[0] | Format-Table
Rule Type            Action Type          Id                   Details
---------            -----------          --                   -------
Persistent, Indexed  Permit               110555               FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 3389|IP_PROTOCOL: Tcp|
```

## Format-CrwdHbfw

`Format-CrwdHbfw` is a custom formatter for the output of `CRWDFWFilter` types. It is not used by default, but can be used to format the output of `Get-CRWDFwFilter`.

Added Benefits:

- Id is shown in decimal and hex
- `FWPM_CONDITION_*` are shown as their names and values, with the exception of FWPM_CONDITION_FLAGS, which is shown as a list of flags
- `FWPM_CONDITION_*` are sorted by their name after the Core Key Properties (Id, RuleType, ActionType, EffectiveWeight)
- Either a single filter or a list of filters can be piped to `Format-CrwdHbfw`

```powershell
PS > (Get-CRWDFwFilter)[0] | Format-CrwdHbfw
ActionType: Permit
EffectiveWeight: 1152921504606856098
Id: 110555 [HEX: 0x1AFDB]
RuleType: Persistent, Indexed
FWPM_CONDITION_FLAGS: FlagsNoneSet:IsLoopback
FWPM_CONDITION_IP_LOCAL_PORT: 3389
FWPM_CONDITION_IP_PROTOCOL: Tcp

PS > Get-CRWDFwFilter -ActionType 'Permit' -LPort 3389 | Format-CrwdHbfw
ActionType: Permit
EffectiveWeight: 1152921504606856098
Id: 110555 [HEX: 0x1AFDB]
RuleType: Persistent, Indexed
FWPM_CONDITION_FLAGS: FlagsNoneSet:IsLoopback
FWPM_CONDITION_IP_LOCAL_PORT: 3389
FWPM_CONDITION_IP_PROTOCOL: Tcp

ActionType: Permit
EffectiveWeight: 1152921504606856097
Id: 110507 [HEX: 0x1AFAB]
RuleType: Persistent, Indexed
FWPM_CONDITION_FLAGS: FlagsNoneSet:IsLoopback
FWPM_CONDITION_IP_LOCAL_PORT: 3389
FWPM_CONDITION_IP_PROTOCOL: Udp
```

## Get-Help

```
NAME
    Get-CrwdHbfw

SYNOPSIS
    Display current CrowdStrike HostBased Firewall filters based on the Windows filter Platform(WFP).


SYNTAX
    Get-CrwdHbfw [[-ActionType] <String>] [[-Id] <String>] [[-RuleType] <String>] [[-LPort] <String>] [[-RPort] <String>] [[-LIP] <String>] [[-RIP] <String>]
    [[-Protocol] <String>] [[-AppId] <String>] [<CommonParameters>]


DESCRIPTION
    The Get-CrwdHbfw function displays current CrowdStrike HostBased Firewall filters based on the Windows filter Platform(WFP).
    Get-CrwdHbfw outputs a list of CRWDFWFilter objects.
    CRWDFWFilter objects are custom objects that contain the following properties:
    Id, ActionType, EffectiveWeight, RuleType, FWPM_CONDITION_*.


PARAMETERS
    -ActionType <String>
        The ActionType parameter specifies the action type of the WFP filter.
        The ActionType parameter must be either 'Permit' or 'Block'.

    -Id <String>
        The Id parameter specifies the Id / FilterId of the WFP filter.

    -RuleType <String>
        The RuleType parameter specifies the RuleType of the WFP filter.
        The RuleType parameter must be either 'Persistent, Indexed' or 'BootTime, Indexed'.

    -LPort <String>
        The LPort parameter specifies the local port of the WFP filter.

    -RPort <String>
        The RPort parameter specifies the remote port of the WFP filter.

    -LIP <String>
        The LIP parameter specifies the local IP address of the WFP filter.

    -RIP <String>
        The RIP parameter specifies the remote IP address of the WFP filter.

    -Protocol <String>
        The Protocol parameter specifies the protocol of the WFP filter.

    -AppId <String>
        The AppId parameter specifies the AppId of the WFP filter.

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

    -------------------------- EXAMPLE 1 --------------------------

    PS>Get-CrwdHbfw -ActionType 'Permit' -LPort 3389

    -------------------------- EXAMPLE 2 --------------------------

    PS>Get-CrwdHbfw -ActionType 'Block' -LPort 50000

    -------------------------- EXAMPLE 3 --------------------------

    PS>Get-CrwdHbfw -ActionType 'Block' -RPort 22 -RIP 10.0.0.0/8

REMARKS
    To see the examples, type: "get-help Get-CrwdHbfw -examples".
    For more information, type: "get-help Get-CrwdHbfw -detailed".
    For technical information, type: "get-help Get-CrwdHbfw -full".
```

## Private Functions

```powershell
PS > Get-StagedWFPFilter | Sort-Object | Format-Table
Rule Type            Action Type          Id                   Details
---------            -----------          --                   -------
Persistent, Indexed  Permit               103665               ALE_APP_ID: \device\harddiskvolume2\windows\system32\svchost.exe|ALE_USER_ID: NT SERVICE\W32Time|FLAGS: FlagsNoneSet:IsLoopback|IP_PROTOCOL: Udp|IP_REMOTE_PORT: 123|
Persistent, Indexed  Permit               103649               ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 136|IP_PROTOCOL: IcmpV6|IP_REMOTE_PORT: 0|
Persistent, Indexed  Permit               103669               ALE_APP_ID: \device\harddiskvolume2\windows\system32\svchost.exe|ALE_USER_ID: NT SERVICE\Dnscache|FLAGS: FlagsNoneSet:IsLoopback|IP_PROTOCOL: Udp|IP_REMOTE_PORT: 53|
Persistent, Indexed  Permit               103651               ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 4|IP_PROTOCOL: IcmpV6|
Persistent, Indexed  Permit               103631               ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_ADDRESS: fe80:: - Prefix: 64|IP_LOCAL_PORT: 134|IP_PROTOCOL: IcmpV6|IP_REMOTE_PORT: 0|
Persistent, Indexed  Permit               103629               ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 134|IP_PROTOCOL: IcmpV6|IP_REMOTE_ADDRESS: fe80:: - Prefix: 64|IP_REMOTE_PORT: 0|
Persistent, Indexed  Permit               103639               ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 132|IP_PROTOCOL: IcmpV6|IP_REMOTE_PORT: 0|
Persistent, Indexed  Permit               103635               ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 133|IP_PROTOCOL: IcmpV6|IP_REMOTE_PORT: 0|
Persistent, Indexed  Permit               103695               ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 135|IP_PROTOCOL: IcmpV6|IP_REMOTE_PORT: 0|
Persistent, Indexed  Block                103675               FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 50000|IP_PROTOCOL: Tcp|
Persistent, Indexed  Permit               103655               ALE_APP_ID: \device\harddiskvolume2\windows\system32\svchost.exe|ALE_USER_ID: NT SERVICE\Dhcp|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 546|IP_PROTOCOL: Udp|IP_REMOTE_PORT: 547|
Persistent, Indexed  Permit               103627               ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 3|IP_PROTOCOL: IcmpV6|
Persistent, Indexed  Permit               103677               ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 131|IP_PROTOCOL: IcmpV6|IP_REMOTE_PORT: 0|
Persistent, Indexed  Permit               103707               ALE_APP_ID: \device\harddiskvolume2\windows\system32\svchost.exe|ALE_USER_ID: NT SERVICE\gpsvc|CURRENT_PROFILE_ID: Domain|FLAGS: FlagsNoneSet:IsLoopback|IP_PROTOCOL: Tcp|
Persistent, Indexed  Permit               103697               ALE_APP_ID: System|CURRENT_PROFILE_ID: Domain|FLAGS: FlagsNoneSet:IsLoopback|IP_PROTOCOL: Tcp|IP_REMOTE_PORT: 445|
Persistent, Indexed  Permit               103641               ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 132|IP_PROTOCOL: IcmpV6|IP_REMOTE_PORT: 0|
Persistent, Indexed  Permit               103685               FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 3389|IP_PROTOCOL: Tcp|
```

```powershell
(Get-StagedWFPFilter)[0].details
ALE_APP_ID: System|FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 136|IP_PROTOCOL: IcmpV6|IP_REMOTE_PORT: 0|
```

```powershell
PS > Get-StagedWFPFilter -Id '110556' | Format-CrwdHbfw                                                                                                                               ActionType: Permit
EffectiveWeight: 1152921504606856098
FWPM_CONDITION_FLAGS: FlagsNoneSet:IsLoopback
FWPM_CONDITION_IP_LOCAL_PORT: 3389
FWPM_CONDITION_IP_PROTOCOL: Tcp
Id: 110556 [HEX: 0x1AFDC]
RuleType: Boottime, Indexed

```

## Enabling Debug

```powershell
Get-CrwdHbfw -ActionType 'Block' -Debug | Format-Table                                                                                                                                  [debug] Get-CrwdHbfw ** ParamHash:
[debug] ------------------
{
    "ActionType":  "Block",
    "Id":  "",
    "RuleType":  "[default]"
}
[debug] ------------------

[debug] Get-StagedWFPFilter
[debug] ------------------
[debug] ActionType: Block
[debug] Id:
[debug] RuleType: Persistent, Indexed
[debug] ------------------
[debug] Get-StagedWFPFilter ** filterstring: ($_.Name -EQ "CrowdStrike WFP Filter") -AND ($_.ActionType -eq 'Block') -AND ($_.Flags -eq 'Persistent, Indexed')

Rule Type            Action Type          Id                   Details
---------            -----------          --                   -------
Persistent, Indexed  Block                110545               FLAGS: FlagsNoneSet:IsLoopback|IP_LOCAL_PORT: 50000|IP_PROTOCOL: Tcp|
```

## Uninstall 

So long and thanks for all the fish. Leave an message or issue on the Github if you did not find this helpful. 

You must use an * elevated rights (Run as Administrator)* powershell session: 

```powershell
Uninstall-Module crwd-hbfw
Uninstall-Module -Name NtObjectManager
```

## Dependency

If you do not install the `NtObjectManager` module per the above instructions, you will get the following error:

```powershell
PS > Get-CrwdHbfw
Missing Required PowerShell Module 'NtObjectManager', with Cmdlet 'Get-FwFilter'
At C:\Users\xxxx\Documents\WindowsPowerShell\Modules\crwd-hbfw\crwd-hbfw.psm1:328 char:9
+         Throw "Missing Required PowerShell Module 'NtObjectManager',  ...
+         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : OperationStopped: (Missing Require... 'Get-FwFilter':String) [], RuntimeException
    + FullyQualifiedErrorId : Missing Required PowerShell Module 'NtObjectManager', with Cmdlet 'Get-FwFilter'
```

## NtObjectManager

*Under the Hood*

`Get-FwFilter` from [NtObjectManager] is the core of `Get-CrwdHbfw`. Its output is filtered by `Get-CrwdHbfw` to only show the filters that are relevant to CrowdStrike HostBased Firewalls implemented by WFP.

`CRWD-HBFW` provides additional types, recursive mapping of the Conditions, and formatters for viewing. Note the below activities would require recursive calls to view the `value` of the `conditionals` which administrators are often in need. (What TCP port is filtered in this rule, Which Application, etc..)

List CrowdStrike Filters using only `NtObjectManager`

```powershell
PS > C:\Users\demo> Get-FwProvider | Where-Object -Property Name -EQ 'CrowdStrike'

KeyName                                Name
-------                                ----
{dd00a9d2-2593-497a-b84e-a1c47ab952d5} CrowdStrike

PS > Get-FwFilter | Where-Object -Property Name -EQ 'CrowdStrike WFP Filter'
FilterId ActionType Name
-------- ---------- ----
110487   Permit     CrowdStrike WFP Filter
110576   Permit     CrowdStrike WFP Filter
110517   Permit     CrowdStrike WFP Filter
(...)

```

Lowlevel request of FW Filter using `Get-FwFilter`

```powershell
PS > Get-FwFilter | Where-Object {($_.FilterId -EQ '110576') -AND ($_.ActionType -EQ 'Permit')}
FilterId ActionType Name
-------- ---------- ----
110576   Permit     CrowdStrike WFP Filter
```

Lowlevel request of FW Filters using `Get-FwFilter` with expanded tabled outputs. `FWPM_Condition_*` values are a sublevel lower.

```powershell
PS > Get-FwFilter | Where-Object -Property FilterId -EQ '110546' | Sort-Object -Property ActionType | Format-Table -Property FilterId,ActionType,Key,Weight,EffectiveWeight,Conditions -AutoSize
FilterId ActionType Key                                  Weight              EffectiveWeight     Conditions
-------- ---------- ---                                  ------              ---------------     ----------
  110546      Block c5996155-fd4e-4838-358e-000000000000 1152921504606856096 1152921504606856096 {FWPM_CONDITION_IP_LOCAL_PORT, FWPM_CONDITION_IP_PROTOCOL, FWPM_CONDITION_FLAGS}
```

Lowlevel request of FW Filter using `Get-FwFilter` with list outputs. `FWPM_Condition_*` values are a sublevel lower.

```powershell
PS > Get-FwFilter | Where-Object -Property FilterId -EQ '110546' | Sort-Object -Property ActionType | Format-List -Property FilterId,ActionType,Key,Weight,EffectiveWeight,Conditions

FilterId        : 110546
ActionType      : Block
Key             : c5996155-fd4e-4838-358e-000000000000
Weight          : 1152921504606856096
EffectiveWeight : 1152921504606856096
Conditions      : {FWPM_CONDITION_IP_LOCAL_PORT, FWPM_CONDITION_IP_PROTOCOL, FWPM_CONDITION_FLAGS}
```

Examine entire `FirewallObject`.

```powershell
PS > Get-FwFilter | Where-Object {$_.FilterId -eq 110576} | Sort-Object | Format-List -Property *

ActionType         : Permit
LayerKey           : c38d57d1-05a7-4c33-904f-7fbceee60e82
LayerKeyName       : FWPM_LAYER_ALE_AUTH_CONNECT_V4
SubLayerKey        : 6f4cf567-44a9-4d00-aa33-e2f2afe237c2
SubLayerKeyName    : {6f4cf567-44a9-4d00-aa33-e2f2afe237c2}
Flags              : Boottime, Indexed
Conditions         : {FWPM_CONDITION_IP_PROTOCOL, FWPM_CONDITION_CURRENT_PROFILE_ID, FWPM_CONDITION_ALE_USER_ID, FWPM_CONDITION_ALE_APP_ID...}
Weight             : 1152921504606856100
ProviderKey        : dd00a9d2-2593-497a-b84e-a1c47ab952d5
ProviderData       : {}
FilterId           : 110576
EffectiveWeight    : 1152921504606856100
FilterType         : 00000000-0000-0000-0000-000000000000
CalloutKey         : 00000000-0000-0000-0000-000000000000
CalloutKeyName     :
IsCallout          : False
HasAppId           : True
HasPackageId       : False
HasUserId          : True
HasRemoteUserId    : False
Key                : c5996155-fd4e-4838-538e-000000000000
Name               : CrowdStrike WFP Filter
Description        :
KeyName            : {c5996155-fd4e-4838-538e-000000000000}
SecurityDescriptor : O:BAG:SYD:AI(A;ID;0xf07ff;;;BA)(A;ID;0x307ff;;;NO)(A;ID;0x307ff;;;S-1-5-80-3088073201-1464728630-1879813800-1107566885-823218052)(A;ID;0x203f4;;;S-1-5-80-3141615172-2057878085-1754447212-2405740020-3916
                     490453)(A;ID;0x307ff;;;S-1-5-80-3044542841-3639452079-4096941652-1606687743-1256249853)(A;ID;0x307ff;;;S-1-5-80-979556362-403687129-3954533659-2335141334-1547273080)(A;ID;0x203f4;;;S-1-5-80-3139157870-2
                     983391045-3678747466-658725712-1809340420)(A;ID;0x307ff;;;S-1-5-80-1510742542-3632397484-604094731-3920060944-1272132581)(A;ID;RPDT;;;WD)
ObjectName         : CrowdStrike WFP Filter
NtType             : Name = Firewall - Index = -1
IsContainer        : False
```

Under `NtObjectManager` version `1.x`

```powershell
(Get-FwFilter | Where-Object {$_.FilterId -eq 110576}).GetType()
IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     False    FirewallFilter                           NtApiDotNet.Net.Firewall.FirewallObject
```
