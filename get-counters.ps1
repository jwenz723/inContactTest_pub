    
[string[]]$fcounters = $param.counters
[string[]]$fmetrics = $param.metrics
[float[]]$fmultipliers = $param.multipliers

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
