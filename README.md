# TrueSite Pulse Plugin For Windows Performance Counter

Template plugin for extracting metrics from the Windows Performance Counter.
This plugin requires powershell v2 or higher. (Run this command in powershell to check the version, look for the number in the 'major' column: $PSVersionTable.PSVersion)

### Prerequisites

|     OS    | Linux | Windows | SmartOS | OS X |
|:----------|:-----:|:-------:|:-------:|:----:|
| Supported |       |    v    |         |      |


#### For Boundary Meter v4.2 or later

- To install new meter go to Settings->Installation or [see instructions](https://help.boundary.com/hc/en-us/sections/200634331-Installation).
- To upgrade the meter to the latest version - [see instructions](https://help.boundary.com/hc/en-us/articles/201573102-Upgrading-the-Boundary-Meter).

#### Performance Counter Collection Setup

This plugin is useable out of the box on COR servers. There are 3 files used to define performance counters that should be collected by this plugin. They are: definition_counters.txt, definition_metrics.txt, and definition_multipliers.txt.  Each performance counter to be collected MUST have a value in each of the 3 files.

The data between these 3 files will be correlated within this plugin based upon the line number of the data within each file. Therefore, if you wish to collect the performance counter "\ASP.NET Apps v4.0.30319(_LM_W3SVC_1_ROOT_inContactAPI)\Requests/Sec", with a pulse metric name of "INC_WEB_API_CALLS_PER_SECOND", and a multipler of "1.0", then these 3 values MUST be on the same line number in their respective files.

#### definition_counters.txt

This file contains the path to each counter you want this plugin to retrieve.

Example:
```
\ASP.NET Apps v4.0.30319(_LM_W3SVC_1_ROOT_inContactAPI)\Requests/Sec
\Processor(0)\% Processor Time
```

#### definition_metrics.txt

This file contains the unique identifier used to identify each performance counter as a metric in pulse. Note if you create a new metric then you should also update the `metrics.json` file located in the respository described in the next section below.  You must also add the metric name to the "metrics" section within plugin.json.

Example:
```
INC_WEB_API_CALLS_PER_SECOND
PROCESSOR_PERCENT_PROCESSOR_TIME
```

#### definition_multipliers.txt

This file contains the value to multiply each performance counter `cooked_value` by from the `PerformanceCounterSample` to get the actual metric value to send to pulse

Example:
```
1.0
0.1
```

#### Metrics Configuration File

This configuration file indicates the metric definitions used by this plugin. Description of each of fields can be founder [here](http://premium-documentation.boundary.com/v1/post/metrics)

```json
{
  "PROCESSOR_PERCENT_PROCESSOR_TIME": {
    "defaultAggregate": "AVG",
    "defaultResolutionMS": 1000,
    "description": "Percentage of CPU used",
    "displayName": "Processor % Time",
    "displayNameShort": "Proc % Time",
    "unit": "percent"
  },
  "MEMORY_COMMITTED_BYTES_IN_USE": {
    "defaultAggregate": "AVG",
    "defaultResolutionMS": 1000,
    "description": "Memory committed bytes in use",
    "displayName": "Memory Committed Bytes",
    "displayNameShort": "Mem Comm. Bytes",
    "unit": "bytecount"
  },
  "PHYSICAL_DISK_PERCENT_DISK_TIME": {
    "defaultAggregate": "AVG",
    "defaultResolutionMS": 1000,
    "description": "Physical Disk Percent Disk Time",
    "displayName": "Physical Disk % Time",
    "displayNameShort": "Disk % Time",
    "unit": "percent"
  }
}
```

