[string[]]$fcounters = $param.counters
[string[]]$fmetrics = $param.metrics
[float[]]$fmultipliers = $param.multipliers

$JSON = '
{
   "name": "some_metric_id",
   "description": "Windows Performance Counter",
   "displayName": "Metric Name",
   "displayNameShort": "metname",
   "unit": "number",
   "defaultAggregate": "avg"
}'

$pair = "jwenz723@gmail.com:59247fb2-727c-45e2-a2a2-e35f66f80b3a"
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)
$basicAuthValue = "Basic $base64"

Invoke-WebRequest -Uri https://api.truesight.bmc.com/v1/metrics -Method POST -Body $JSON -Headers @{Authorization = "$basicAuthValue"} -ContentType 'application/json'

$hostname = Get-Content Env:\COMPUTERNAME

$multipliers = @{}
$metric_ids = @{}
$i = 0

foreach ($counter in $fcounters) {
  $key = "\\$hostname$counter".ToUpper()

  # Add values to the lookup maps
  $multipliers[$key] = $fmultipliers[$i]
  $metric_ids[$key] = $fmetrics[$i]
  
  $i++
}

# Continuously loop collecting metrics from the Windows Performance Counters
while($true)
{
    Write-Host "some_metric_id" "123" $hostname
    Start-Sleep -m 1000
}
