# CMD Context Menu Manager

A lightweight Windows batch script to manage Command Prompt (CMD) context menu entries in File Explorer.

## Features

- Install **Open CMD Here** context menu entry.
- Install **Open CMD Here as Administrator**.
- Install both options at once.
- Uninstall installed context menu entries.
- Supports folders, folder backgrounds, and drives.
- Uses `HKEY_CURRENT_USER` registry entries.
- No additional software or dependencies required.

## Supported Locations

| Location | Standard CMD | Administrator CMD |
|---|---|---|
| Folder | Yes | Yes |
| Folder Background | Yes | Yes |
| Drive | Yes | Yes |

## Requirements

- Windows 10 or Windows 11
- Windows Command Prompt
- PowerShell (included with Windows)

## Usage

1. Download `CMD-Context-Menu-Manager.bat`.
2. Run the batch file.
3. Select an option from the menu.
4. Follow the on-screen instructions.

## Registry

This script creates context menu entries under:

`HKEY_CURRENT_USER\Software\Classes`

It does not directly modify Windows system-wide registry entries.

## Disclaimer

This project is provided as-is. Always review scripts before running them. Registry changes may affect Windows File Explorer behavior.

## License

MIT License
