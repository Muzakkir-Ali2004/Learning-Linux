# Linux System Monitor

A Bash-based Linux monitoring tool that displays system resource usage, identifies resource-heavy processes, and generates automated health reports.

## Features

- CPU utilisation monitoring using `/proc/stat`
- Memory monitoring using `free` and `awk`
- Disk usage monitoring using `df`
- Top five CPU-consuming processes
- Top five memory-consuming processes
- Automatic resource usage warnings
- Timestamped monitoring reports

## Requirements

- Linux
- Bash
- Standard Linux utilities

## Usage

Make the script executable:

```bash
chmod +x system-monitor.sh
```

Run the monitor:

```bash
./system-monitor.sh
```

## Alert Thresholds

| Resource | Warning threshold |
|---|---|
| CPU | 80% |
| Memory | 80% |
| Disk | 85% |

Thresholds can be modified inside the script.

## Reports

Monitoring reports are automatically generated inside the `reports/` directory.

Reports are excluded from Git tracking.

## Technologies Used

Bash, Linux, Git, awk, ps, free, df, and /proc/stat.

## Future Improvements

- Continuous monitoring
- Email notifications
- Configurable thresholds
- Historical performance tracking

## Project Purpose

Created as part of my Linux and DevOps learning portfolio to develop practical system monitoring and automation skills.
