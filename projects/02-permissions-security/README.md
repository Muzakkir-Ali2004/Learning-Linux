# Linux Permissions & Security Auditor

A Bash-based security auditing tool that scans Linux directories for potentially insecure file permissions and exposed sensitive files.

This project is part of my hands-on Linux learning journey, focusing on file permissions, Bash scripting, security auditing and system administration.

## Features

- Detects world-writable files.
- Identifies world-readable files.
- Flags potentially sensitive files that are world-readable.
- Counts security warnings and informational findings.
- Generates a security audit report automatically.
- Supports scanning different directories.

## How It Works

The script uses Linux's `find` command to inspect file permissions.

It checks for:

| Security Check | Command | Purpose |
|---|---|---|
| World-writable files | `find -perm -0002` | Identifies files writable by others |
| World-readable files | `find -perm -0004` | Identifies files readable by others |
| Sensitive files | Bash `case` patterns | Flags potentially sensitive filenames |

Sensitive filename patterns include:

- `*password*`
- `*.env`
- `*secret*`
- `*credential*`

These checks help identify potential security risks. Findings require further investigation because permissions alone do not establish whether a file is vulnerable.

## Usage

Clone the repository:

```bash
git clone https://github.com/Muzakkir-Ali2004/Learning-Linux.git
```

Navigate to the project:

```bash
cd Learning-Linux/projects/02-permissions-security
```

Run the security auditor:

```bash
bash security-audit.sh
```

Enter the directory you want to scan when prompted.

For example:

```text
Enter the directory to scan: /home/user/Documents
```

## Example Output

```text
Checking for world-writable files...
[WARNING] World-writable file: backup.sh

Checking for world-readable files...
[INFO] World-readable file: public.txt
[INFO] World-readable file: passwords.txt

Checking for exposed sensitive files...
[WARNING] Potentially sensitive file is world-readable: passwords.txt

====================================
Security Audit Summary
Warnings: 2
Informational findings: 2
====================================
```

## Security Testing

I tested the auditor by deliberately modifying file permissions in a controlled environment.

### Test 1: Remediating an Insecure File

Changed a test file's permissions from `777` to `700`.

The auditor correctly stopped reporting the file as world-writable.

### Test 2: Detecting Exposed Configuration Files

Changed a dummy `production.env` file from `600` to `644`.

The auditor successfully detected that the potentially sensitive file had become world-readable.

### Test 3: Verifying Secure Permissions

Restored restrictive permissions on sensitive test files.

Final audit results:

```text
Warnings: 0
Informational findings: 1
```

## Technologies Used

- Linux
- Bash
- Git and GitHub
- Linux file permissions
- `find`, `chmod`, `basename` and `tee`

## What I Learned

Through this project, I gained practical experience with:

- Understanding Linux file permissions and octal notation.
- Identifying potentially insecure file configurations.
- Writing Bash scripts with loops and conditional statements.
- Using `find` to search for files based on permissions.
- Implementing counters and generating reports.
- Testing security vulnerabilities and verifying remediation.
- Documenting and version-controlling a Linux project.

## Future Improvements

- Add command-line arguments for directory selection.
- Support recursive scanning with configurable exclusions.
- Add timestamps to security reports.
- Export findings in JSON or CSV format.
- Improve sensitive filename detection.
- Add severity levels for different security findings.

---

Part of my [Learning Linux](https://github.com/Muzakkir-Ali2004/Learning-Linux) portfolio.
