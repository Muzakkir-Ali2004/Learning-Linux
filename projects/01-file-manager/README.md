# Linux File Manager 

This is my first Bash automation project, built while learning Linux and shell scripting.

## 📌 About the Project

This script automatically organises files into folders based on their file extensions.

Instead of manually sorting files, the user enters a directory path and the script handles the organisation.

## ⚙️ Features

- Organises JPG, JPEG and PNG files into an Images folder.
- Organises PDF and TXT files into a Documents folder.
- Organises Bash scripts into a Scripts folder.
- Checks whether the selected directory exists.
- Checks directory write permissions.
- Prevents existing destination files from being overwritten.
- Records file operations in a log.
- Displays how many files were moved or skipped.

## 🛠️ Technologies Used

- Linux (Ubuntu)
- Bash scripting
- Git and GitHub

## 📂 Example

Before running the script:

```text
file-manager-test/
├── photo.jpg
├── report.pdf
├── notes.txt
└── backup.sh
```

After running the script:

```text
file-manager-test/
├── Images/
│   └── photo.jpg
├── Documents/
│   ├── report.pdf
│   └── notes.txt
├── Scripts/
│   └── backup.sh
└── file-manager.log
```

## 🚀 How to Run

Clone the repository:

```bash
git clone https://github.com/Muzakkir-Ali2004/Learning-Linux.git
```

Navigate to the project:

```bash
cd Learning-Linux/projects/01-file-manager
```

Make the script executable:

```bash
chmod +x file-manager.sh
```

Run it:

```bash
./file-manager.sh
```

Enter the full path of the directory you want to organise.

**Warning:** The script moves files. Test it on a folder containing dummy files before using it on important data.

## 🧠 What I Learned

Building this project helped me practise:

- Writing and executing Bash scripts.
- Using variables and reading user input.
- Writing `if` statements and `case` statements.
- Using loops to process multiple files.
- Checking file permissions.
- Handling errors and duplicate filenames.
- Recording script activity using logging.
- Debugging Bash syntax errors.

## 🐛 Challenges I Encountered

One issue I encountered was incorrect spacing inside Bash conditions.

Initially, I wrote:

```bash
if [-d "$folder" ]; then
```

This resulted in:

```text
[-d: command not found
```

I learned that Bash requires spaces around the square brackets:

```bash
if [ -d "$folder" ]; then
```

I also encountered a missing closing bracket error while fixing the condition.

After correcting the syntax, I tested the script again and confirmed it worked.

## 🔮 Future Improvements

- Support more file extensions.
- Allow users to customise destination folders.
- Add a preview mode before moving files.
- Improve handling of filenames and unusual filesystem conditions.
