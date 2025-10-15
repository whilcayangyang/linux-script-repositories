# linux-script-repositories

A curated collection of Linux scripts, post-install guides, and manual instructions for system administration, automation, and network tools.

## Table of Contents

- [Overview](#overview)
- [Repository Files](#repository-files)
- [How to Use](#how-to-use)
- [File Categories & Naming Conventions](#file-categories--naming-conventions)
- [Adding Scripts or Manuals](#adding-scripts-or-manuals)
- [Testing & Quality](#testing--quality)
- [Contributing](#contributing)
- [License & Contact](#license--contact)

## Overview

This repository contains step-by-step manuals, post-install scripts, and configuration guides for various Linux distributions and network tools. Each file is self-contained and provides clear instructions for installation, configuration, or recovery tasks.

## Repository Files

| Filename                                                        | Category         | Description                                               |
|-----------------------------------------------------------------|------------------|-----------------------------------------------------------|
| README.md                                                       | Documentation    | This file. Project overview and file index.               |
| LICENSE                                                         | Legal            | GNU GPLv3 License text.                                   |
| After installing Fedora Workstation.md                          | Fedora           | Fedora post-install script manual.                        |
| After installing Debian Gnome Desktop.md                        | Debian           | Debian GNOME post-install script manual.                  |
| After installing Endeavour Linux.md                             | Arch/EndeavourOS | EndeavourOS post-install manual.                          |
| How to install GNS3 on Ubuntu Based Distro.md                   | Ubuntu           | GNS3 installation guide for Ubuntu-based distros.         |
| How to install GNS3 on Debian.md                                | Debian           | GNS3 installation guide for Debian.                       |
| How to install GNS3 on Arch Based Linux.md                      | Arch             | GNS3 installation guide for Arch-based distros.           |
| Install and Configure ClamAV in Fedora 42.md                    | Fedora           | ClamAV installation and configuration for Fedora 42.      |
| TP-Link AX23 Revert Stock Firmware.md                           | Networking       | Manual for reverting TP-Link AX23 to stock firmware.      |

## How to Use

- Browse the repository and select the relevant `.md` file for your distribution or task.
- Follow the step-by-step instructions in each manual.
- For scripts, copy and paste commands into your terminal.
- Always review commands before running, especially those that modify system files or firmware.

## File Categories & Naming Conventions

- **Distribution Manuals:**  
  - `After installing <Distro>.md` — Post-install guides for specific distros.
- **Tool/Software Guides:**  
  - `How to install <Tool> on <Distro>.md` — Installation/configuration for tools.
- **Security/Networking:**  
  - `<Device/Tool> <Action>.md` — Firmware, recovery, or network device guides.
- **General:**  
  - Use clear, descriptive filenames.  
  - All files are Markdown for readability.

## Adding Scripts or Manuals

1. Create a new Markdown file with a descriptive name.
2. Add a clear title, short intro, and step-by-step instructions.
3. Use fenced code blocks for commands.
4. Update the "Repository Files" table in this README to include your new file.

## Testing & Quality

- All instructions should be tested on a clean system or VM.
- Use comments to clarify risky or optional steps.
- Prefer official sources for downloads and package installation.

## Contributing

- Fork the repository and submit a pull request.
- Keep instructions concise and accurate.
- Update the README file index when adding or removing files.
- Use Markdown formatting for clarity.

## License & Contact

- License: GNU GPLv3 (see LICENSE file).
- For questions or suggestions, open an issue or submit a PR.

---
