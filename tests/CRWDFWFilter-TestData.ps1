$T = [CRWDFWFilter]@{
    Id                            = "12345"
    ActionType                    = "Permit"
    EffectiveWeight               = "1152921504606847071"
    FWPM_CONDITION_IP_PROTOCOL    = "IcmpV6"
    FWPM_CONDITION_IP_LOCAL_PORT  = "2"
    FWPM_CONDITION_IP_REMOTE_PORT = "0"
    FWPM_CONDITION_ALE_APP_ID     = "System"
    FWPM_CONDITION_FLAGS          = "FlagsNoneSet IsLoopback"
}

$D = [CRWDFWFilter]@{
    Id                            = "67407"
    ActionType                    = "Block"
    EffectiveWeight               = "1123"
    FWPM_CONDITION_IP_PROTOCOL    = "IcmpV4"
    FWPM_CONDITION_IP_LOCAL_PORT  = "1"
    FWPM_CONDITION_IP_REMOTE_PORT = "0"
    FWPM_CONDITION_ALE_APP_ID     = "System"
    FWPM_CONDITION_FLAGS          = "FlagsNoneSet IsLoopback"
}

$E = [CRWDFWFilter]::new()
$E.Id = "23456"
$E.ActionType = "Permit"
$E.EffectiveWeight = "1152921504606847071"
$E.FWPM_CONDITION_IP_PROTOCOL = "TCP"
$E.FWPM_CONDITION_IP_LOCAL_PORT = "3388"
$E.FWPM_CONDITION_IP_REMOTE_PORT = "0"
$E.FWPM_CONDITION_ALE_APP_ID = "System"
$E.FWPM_CONDITION_FLAGS = "FlagsNoneSet IsLoopback"

$F = @($T, $D, $E)

$F | Format-CrwdHbfw