$error.Clear()

# Credentials for posting metrics into Pulse
$pair = "jwenz723@gmail.com:59247fb2-727c-45e2-a2a2-e35f66f80b3a"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"

# Get the path to the param.json file
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$jsonConfig = Get-Content $dir\param.json

[System.Reflection.Assembly]::LoadWithPartialName("System.Web.Extensions")
$ser = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$obj = $ser.DeserializeObject($jsonConfig)

foreach ($item in $obj.items) {
    $metric_name = $item.metric_name
    $metric_short_name = $item.metric_short_name
    $metric_identifier = $item.metric_identifier
    $counter = $item.counter
    $multipler = $item.multiplier

    echo "Got $metric/$counter/$multipler"

    $JSON = '
    {
       "name": "' + $metric_identifier + '",
       "description": "Windows Performance Counter",
       "displayName": "' + $metric_name + '",
       "displayNameShort": "' + $metric_short_name + '",
       "unit": "number",
       "defaultAggregate": "avg"
    }'


    Try
    {
        $output = Invoke-WebRequest -Uri https://api.truesight.bmc.com/v1/metrics -Method POST -Body $JSON -Headers @{Authorization = "$basicAuthValue"} -ContentType 'application/json'  
        echo "created metric"
    }
    Catch
    {
        echo "error " $Error
    }
}

return





$hostname = Get-Content Env:\COMPUTERNAME


# Continuously loop collecting metrics from the Windows Performance Counters
#while($true)
#{
#    Write-Host "SOME_METRIC_ID2" "123" $hostname
#    [Console]::Error.WriteLine("SOME_METRIC_ID2 123 $hostname")
#    Start-Sleep -m 1000
#}
