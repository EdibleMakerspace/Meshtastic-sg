<#
.SYNOPSIS
  Configure a Meshtastic board for Singapore (region SG_923) from Windows PowerShell.

.DESCRIPTION
  Installs/updates the Meshtastic Python CLI, finds the board's COM port, shows the
  current region, asks you to confirm, then sets:
    region SG_923, preset LONG_FAST, transmit on, owner names, and the UTC+8 time zone.
  It never prints `--info` (that output contains your private key and WiFi password).
  Flash the firmware first with https://flasher.meshtastic.org/ (Chrome or Edge).

.PARAMETER Port       COM port, e.g. COM5. Auto-detected when exactly one board is plugged in.
.PARAMETER Name       Long node name.  Default "EMS node".
.PARAMETER ShortName  Short node name (max 4 characters). Default "EMS1".
.PARAMETER Yes        Skip the confirmation prompt.

.EXAMPLE
  .\setup-sg.ps1
  .\setup-sg.ps1 -Port COM5 -Name "EMS workshop node" -ShortName EMS1
#>
param(
  [string]$Port,
  [string]$Name = "EMS node",
  [string]$ShortName = "EMS1",
  [switch]$Yes
)

$ErrorActionPreference = "Stop"

function Invoke-Mesh {
  param([string[]]$MeshArgs)
  & py -m meshtastic @MeshArgs
  if ($LASTEXITCODE -ne 0) { throw "meshtastic exited with code $LASTEXITCODE" }
}

# 1. Python launcher
if (-not (Get-Command py -ErrorAction SilentlyContinue)) {
  throw "Python launcher 'py' not found. Install Python from https://www.python.org/downloads/windows/ (tick 'Add python.exe to PATH') or run: winget install Python.Python.3.12"
}

# 2. Meshtastic CLI
Write-Host "Step 1/5: installing or updating the Meshtastic CLI..." -ForegroundColor Cyan
& py -m pip install --upgrade "meshtastic[cli]" | Out-Null
if ($LASTEXITCODE -ne 0) { throw "pip install failed" }

# 3. COM port
Write-Host "Step 2/5: looking for the board..." -ForegroundColor Cyan
if (-not $Port) {
  $ports = @([System.IO.Ports.SerialPort]::GetPortNames())
  if ($ports.Count -eq 0) {
    throw "No COM ports found. Use a USB data cable, try another USB port, or hold BOOT, tap RESET, release BOOT. See docs/windows-setup.md"
  } elseif ($ports.Count -eq 1) {
    $Port = $ports[0]
    Write-Host "  Found one port: $Port"
  } else {
    Write-Host "  Several ports found: $($ports -join ', ')"
    $Port = Read-Host "  Which one is the Meshtastic board? (e.g. COM5)"
  }
}

# 3. Show what is on the board now
Write-Host "Step 3/5: current radio region on $Port..." -ForegroundColor Cyan
Invoke-Mesh @("--port", $Port, "--get", "lora.region")

# 4. Confirm
if (-not $Yes) {
  Write-Host ""
  Write-Host "About to change the board on $Port to:" -ForegroundColor Yellow
  Write-Host "  region SG_923 (917-925 MHz), preset LONG_FAST, transmit enabled"
  Write-Host "  name '$Name' / '$ShortName', time zone UTC+8 (Singapore)"
  Write-Host "The board will reboot. Attach the antenna before continuing."
  $answer = Read-Host "Continue? (y/N)"
  if ($answer -notmatch '^(y|yes)$') { Write-Host "Cancelled. Nothing was changed."; return }
}

# 5. Apply
Write-Host "Step 4/5: setting the LoRa region and preset (the board reboots)..." -ForegroundColor Cyan
Invoke-Mesh @("--port", $Port,
  "--set", "lora.region", "SG_923",
  "--set", "lora.modem_preset", "LONG_FAST",
  "--set", "lora.use_preset", "true",
  "--set", "lora.tx_enabled", "true")
Write-Host "  Waiting 25 seconds for the reboot..."
Start-Sleep -Seconds 25

Write-Host "Step 5/5: setting names and time zone..." -ForegroundColor Cyan
Invoke-Mesh @("--port", $Port, "--set-owner", $Name, "--set-owner-short", $ShortName)
Start-Sleep -Seconds 8
Invoke-Mesh @("--port", $Port, "--set", "device.tzdef", "<+08>-8")
Start-Sleep -Seconds 8

# Verify
Write-Host ""
Write-Host "Done. Region now reads:" -ForegroundColor Green
Invoke-Mesh @("--port", $Port, "--get", "lora.region")
Write-Host "The default LongFast channel should be on 917.875 MHz (slot 3 of 32)."
Write-Host "Next: py radio_check.py --port $Port    (checks the frequency and listens for other nodes)"
