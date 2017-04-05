#$JSON = '
#{
#   "name": "SOME_METRIC_ID2",
#   "description": "Windows Performance Counter",
#   "displayName": "Metric Name",
#   "displayNameShort": "metname",
#   "unit": "number",
#   "defaultAggregate": "avg"
#}'

$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$jsonConfig = Get-Content $dir\param.json

[System.Reflection.Assembly]::LoadWithPartialName("System.Web.Extensions")
$ser = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$obj = $ser.DeserializeObject($jsonConfig)

[Console]::Error.WriteLine($obj)

foreach ($item in $obj.items) {
    $metric = $item.metric
    $counter = $item.counter
    $multipler = $item.multiplier

    throw [System.IO.FileNotFoundException] "Got $metric/$counter/$multipler"
}

return

$pair = "jwenz723@gmail.com:59247fb2-727c-45e2-a2a2-e35f66f80b3a"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"

Try
{
    #$output = Invoke-WebRequest -Uri https://api.truesight.bmc.com/v1/metrics -Method POST -Body $JSON -Headers @{Authorization = "$basicAuthValue"} -ContentType 'application/json'  
}
Catch
{

}

$hostname = Get-Content Env:\COMPUTERNAME


# Continuously loop collecting metrics from the Windows Performance Counters
#while($true)
#{
#    Write-Host "SOME_METRIC_ID2" "123" $hostname
#    [Console]::Error.WriteLine("SOME_METRIC_ID2 123 $hostname")
#    Start-Sleep -m 1000
#}
