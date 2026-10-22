# Linux Server Log Analyser

A Bash-based log analysis tool designed to examine Apache and Nginx-style web server access logs, identify HTTP errors, analyse request patterns and highlight potentially suspicious activity.

Part of my hands-on Linux, cybersecurity and DevOps portfolio.

## Features

- Counts total HTTP requests
- Identifies HTTP 200, 403, 404 and 500 responses
- Displays the five most active IP addresses
- Flags IP addresses exceeding a request-count threshold
- Summarises HTTP errors
- Generates timestamped analysis reports
- Supports Apache and Nginx-style access logs

## Technologies Used

- Linux
- Bash
- AWK
- grep, sort, uniq and head
- Git and GitHub

## Requirements

- Linux operating system
- Bash
- Standard GNU command-line utilities
- Apache or Nginx-style access log

## Usage

Make the script executable:

```bash
chmod +x log-analyser.sh
```

Run the analyser:

```bash
./log-analyser.sh /path/to/access.log
```

For the included test data:

```bash
./log-analyser.sh test-logs/access.log
```

## Example Output

```text
REQUEST STATISTICS
----------------------------------------
Total Requests: 35
HTTP 200: 17
HTTP 403: 7
HTTP 404: 8
HTTP 500: 3

TOP 5 REQUESTING IP ADDRESSES
----------------------------------------
15 192.0.2.10
10 203.0.113.30
10 198.51.100.20

HTTP ERROR SUMMARY
----------------------------------------
HTTP 403: 7
HTTP 404: 8
HTTP 500: 3
```

## Security Monitoring

The analyser flags IP addresses generating 10 or more requests.

This threshold is intentionally low for demonstration purposes.

High request volumes do not necessarily indicate malicious activity. Further investigation is required to distinguish normal traffic from potential attacks.

## Testing

The script was tested using 35 synthetic web server requests.

The test dataset included:

- Successful HTTP 200 responses
- Forbidden HTTP 403 responses
- Not Found HTTP 404 responses
- Internal Server Error HTTP 500 responses
- Multiple IP addresses generating different request volumes

The analyser successfully identified the expected results.

## Reports

Reports are automatically saved in the `reports/` directory using timestamps.

Generated reports are excluded from Git tracking.

## Future Improvements

- Configurable detection thresholds
- Failed SSH login analysis
- Real-time log monitoring
- IP-based request-rate analysis
- CSV and JSON exports
- Automated alert notifications

## Project Purpose

Developed to practise Linux command-line utilities, Bash automation, log analysis and security monitoring.

This project demonstrates foundational skills relevant to Linux administration, cybersecurity and DevOps.
