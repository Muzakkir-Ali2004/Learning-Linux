# Linux System Monitor

A Bash-based Linux system monitoring tool that reports system resource usage, identifies resource-heavy processes and highlights potential performance issues.

## Features

- Calculates CPU utilisation using `/proc/stat`.
- Monitors memory usage using `free` and `awk`.
- Checks root filesystem utilisation.
- Displays the five highest CPU-consuming processes.
- Displays the five highest memory-consuming processes.
- Generates warnings when resource thresholds are exceeded.
- Creates timestamped monitoring reports.

## Requirements

- Linux
- Bash
- Standard Linux utilities: `awk`, `free`, `df`, `ps`, `head`, `date`

## Usage

```bash
chmod +x system-monitor.sh
./system-monitor.sh


### Prevent generated reports from being uploaded

```bash
cat > .gitignore <<'EOF'
reports/
