---
title: Getting started with Meshtastic in Singapore on Windows - flash, set SG_923, send a message
description: Step-by-step Meshtastic setup for Singapore on Windows 10/11 - flash firmware with the web flasher, install the Python CLI, set region SG_923 and LONG_FAST, check the default channel and send a first message from PowerShell.
---

# Getting started (Singapore, Windows)

**To get two Meshtastic boards talking in Singapore: flash the same firmware on both, set the region to `SG_923`, leave the preset and channel at their defaults, and send a message.** This page shows each step with PowerShell commands. Total: **7 steps**.

> **Kitchen analogy:** flashing is buying the same recipe book for every cook; the region is the kitchen's food-safety code; the preset and channel are the agreed shelf and jar label. Skip one and the cooks can't swap dishes.

New to Windows and serial ports? Read [Windows setup](windows-setup.md) first (about 10 minutes). Prefer a script? Run [`tools/setup-sg.ps1`](https://github.com/EdibleMakerspace/Meshtastic-sg/blob/main/tools/setup-sg.ps1), which does steps 2–5 with a confirmation before it changes anything.

## 1. Flash the firmware

1. Plug the board into your PC with a **data** USB-C cable (some cables only carry power).
2. Open the [Meshtastic Web Flasher](https://flasher.meshtastic.org/) in **Chrome or Edge**, because it needs Web Serial.
3. Pick your exact board (for the Seeed kit: the **XIAO ESP32S3 + Wio-SX1262** entry) and a firmware version. Use the **same version on every board**.
4. Tick **Full erase** when changing between major versions, then **Flash**.
5. If the flasher can't see the board, put it in bootloader mode: hold **BOOT**, tap **RESET**, release **BOOT**, then try again.

Official guide: [Flashing firmware](https://meshtastic.org/docs/getting-started/flashing-firmware/).

## 2. Install the command-line tool

Open **PowerShell** and run:

```powershell
py -m pip install --upgrade "meshtastic[cli]"
py -m meshtastic --version
```

Use `py -m meshtastic …` for every command below. It always works, even when `meshtastic.exe` isn't on your PATH. See the [CLI installation guide](https://meshtastic.org/docs/software/python/cli/installation/). Only one program can use a COM port at a time, so close the web client, the panel, PuTTY, the Arduino serial monitor and any other CLI first.

## 3. Find your COM port and set the region (required)

```powershell
[System.IO.Ports.SerialPort]::GetPortNames()        # e.g. COM5
py -m meshtastic --port COM5 --set lora.region SG_923
```

After flashing, the region is unset and **the radio will not transmit until you set it**. The board reboots; wait about 20 seconds before the next command. If only one board is plugged in you can leave out `--port COM5`.

## 4. Match the radio settings

These are the defaults, so a fresh board already has them. Run this if a board was changed before:

```powershell
py -m meshtastic --port COM5 --set lora.modem_preset LONG_FAST --set lora.use_preset true `
  --set lora.channel_num 0 --set lora.override_frequency 0 --set lora.frequency_offset 0 `
  --set lora.tx_enabled true --set lora.sx126x_rx_boosted_gain true
py -m meshtastic --port COM5 --ch-index 0 --ch-set psk default
```

In PowerShell a line ends with a **backtick** `` ` `` (not the `\` used in Linux and macOS guides).

## 5. Name the node and set the time zone (optional)

```powershell
py -m meshtastic --port COM5 --set-owner "EMS workshop node" --set-owner-short EMS1
py -m meshtastic --port COM5 --set device.tzdef '<+08>-8'
```

Singapore is UTC+8 with no daylight saving. Use single quotes around the time-zone string so PowerShell leaves the `<` and `>` alone.

## 6. Send a message and listen

```powershell
py -m meshtastic --port COM5 --sendtext "hello from Singapore"
py -m meshtastic --port COM5 --listen          # shows packets as they arrive (Ctrl+C to stop)
```

Or connect in a browser with the [Meshtastic web client](https://client.meshtastic.org/), or the phone app over Bluetooth.

## 7. Confirm two boards hear each other

Use [`tools/radio_check.py`](https://github.com/EdibleMakerspace/Meshtastic-sg/tree/main/tools) on each board. It prints the radio settings, listens for a few minutes and compares the two boards side by side. The expected frequency for both is **917.875 MHz**.

```powershell
cd tools
py radio_check.py --port COM5
```

> **Careful when sharing output:** `meshtastic --info` prints the node's **private key** and your **WiFi password** if one is set. Don't paste it publicly. `radio_check.py` and the control panel hide these.

## Using the control panel instead

Once the region is set, the [control panel](control-panel.md) can switch a board between the modes used in this project with one click.

Next: **[Singapore: SG_923](singapore-sg923.md)** →
