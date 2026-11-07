---
title: Meshtastic on Windows 10/11 - Python, COM ports, drivers, PowerShell and common errors
description: Everything Windows-specific for a Meshtastic setup - installing Python, finding the COM port of a Seeed XIAO ESP32S3, flashing in Chrome or Edge, PowerShell quirks, virtual environments and the errors you are most likely to see.
---

# Windows setup

**On Windows you need four things: Python, a data USB-C cable, Chrome or Edge, and PowerShell.** The Seeed XIAO ESP32S3 shows up as a COM port using the driver Windows already ships, so there is normally nothing extra to install. This page covers the parts that differ from the macOS and Linux guides.

> **Kitchen analogy:** think of this page as *mise en place*. Ten minutes of laying out your tools saves an hour of hunting for the right spoon mid-recipe.

## What you need

| # | Item | Why | Check |
|---|---|---|---|
| 1 | Windows 10 or 11 | Web Serial and the built-in USB serial driver | `winver` |
| 2 | Python 3.10 or newer | Runs the CLI, the panel and the tools | `py --version` |
| 3 | Chrome or Edge | The web flasher needs Web Serial (Firefox and Safari don't have it) | open [flasher.meshtastic.org](https://flasher.meshtastic.org/) |
| 4 | A USB-C **data** cable | Charge-only cables show no COM port | Device Manager shows a new port when plugged in |
| 5 | The board **with its antenna attached** | Transmitting without an antenna can damage the radio | see [Hardware](hardware.md) |
| 6 | PowerShell (built in) | Command examples in this guide | press **Win**, type `powershell` |

*Total: 6 items.*

## 1. Install Python

Either install from [python.org](https://www.python.org/downloads/windows/) (tick **Add python.exe to PATH**), or from PowerShell:

```powershell
winget install Python.Python.3.12
```

Close and reopen PowerShell, then check:

```powershell
py --version
```

Use the **`py` launcher** in this guide. It finds the right Python even when `python` isn't on your PATH or Windows opens the Microsoft Store instead.

## 2. Find the COM port

Plug the board in, then either open **Device Manager → Ports (COM & LPT)**, or run:

```powershell
[System.IO.Ports.SerialPort]::GetPortNames()
```

A Seeed XIAO ESP32S3 running Meshtastic appears as a **USB Serial Device (COMx)**, with USB ID `303A:1001` (Espressif). If the list is empty:

1. Try a different cable (the most common cause), then a different USB port.
2. Put the board in bootloader mode: hold **BOOT**, tap **RESET**, release **BOOT**. A new COM port should appear.
3. Check Device Manager for a yellow warning icon under *Other devices*.

## 3. Flash in Chrome or Edge

Follow [Getting started, step 1](getting-started.md#1-flash-the-firmware). When the browser asks which port to use, pick the one that appears and disappears as you unplug the board. After flashing, the COM **number may change**: re-check with the command above.

## 4. PowerShell quirks

| Linux/macOS habit | On Windows PowerShell |
|---|---|
| `\` to continue a line | a backtick `` ` `` at the end of the line |
| `python3` | `py` |
| `source venv/bin/activate` | `.\venv\Scripts\Activate.ps1` |
| `/dev/ttyACM0`, `/dev/cu.usbmodem1101` | `COM5` (your number) |
| `meshtastic --info` | `py -m meshtastic --info` (works even if `meshtastic.exe` isn't on PATH) |
| `export PYTHONUTF8=1` | `$env:PYTHONUTF8 = "1"` |
| single quotes for `!a1f80938` | single quotes too; PowerShell also leaves `<+08>-8` alone inside them |

*Total: 7 translations.*

## 5. Run the panel on Windows

```powershell
git clone https://github.com/EdibleMakerspace/Meshtastic-sg.git
cd Meshtastic-sg\panel
py -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
python server.py --mock          # simulated board, no hardware needed
python server.py --port COM5     # real board
```

Then open <http://127.0.0.1:8080>.

- **"running scripts is disabled on this system"** when activating the venv: run `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` once, or use `.\venv\Scripts\activate.bat` from Command Prompt.
- **Windows Defender Firewall prompt** appears if you start the panel with `--host 0.0.0.0`. Allow *private* networks only, and always use `--token`.
- **Non-English messages:** the panel reads and writes its files as UTF-8, so Chinese, Tamil and Malay text is safe. If a terminal shows garbled characters, run `$env:PYTHONUTF8 = "1"` first.

## Common Windows errors

| You see | Meaning | Fix |
|---|---|---|
| `py : The term 'py' is not recognized` | Python isn't installed or PATH wasn't ticked | Reinstall Python and tick *Add to PATH*; reopen PowerShell |
| `PermissionError(13, 'Access is denied.')` or `could not open port 'COM5'` | Another program holds the port | Close the web client, flasher serial monitor, panel, PuTTY, Arduino IDE; unplug and replug |
| `No Serial Meshtastic device detected` | No board found, or several found | Check the cable; pass `--port COM5` explicitly |
| `meshtastic : The term 'meshtastic' is not recognized` | The Scripts folder isn't on PATH | Use `py -m meshtastic …` |
| Flasher shows no devices | Not Chrome/Edge, power-only cable, or board not in bootloader mode | See step 2 above |
| `running scripts is disabled on this system` | PowerShell execution policy | `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` |
| COM port number changed after flashing | Normal for ESP32-S3 native USB | Re-run `GetPortNames()` |

*Total: 7 errors.*

Next: **[Hardware](hardware.md)** →
