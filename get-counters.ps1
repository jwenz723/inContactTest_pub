    
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
    $counters = Get-Counter -Counter $fcounters
    #$timestamp = [math]::Round((Get-Date -Date (Get-Date).toUniversalTime() -UFormat %s))
    $samples = $counters.CounterSamples
    foreach ($s in $samples) {
        $value = $s.CookedValue * $multipliers[$s.path]
        $metric_id = $metric_ids[($s.path).toUpper()]
        Write-Host "some_metric_id" $value $hostname
    }
    Start-Sleep -m 1000
}
