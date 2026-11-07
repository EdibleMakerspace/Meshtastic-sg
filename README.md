# Meshtastic LoRa mesh for Singapore: a Windows-friendly control panel, tools and beginner's guide

**Off-grid text messaging and simple sensors over LoRa radio, using [Meshtastic](https://meshtastic.org/) on cheap ESP32-S3 boards, set up for Singapore (region `SG_923`, 917–925 MHz) and for Windows 10/11.**
This repository holds a small web control panel, two diagnostic scripts, a one-shot PowerShell setup script and a step-by-step guide written for makers, citizen scientists, and anyone who knows WiFi and Bluetooth but is new to LoRa.

📖 **Read the guide online:** <https://ediblemakerspace.github.io/Meshtastic-sg/> *(after enabling GitHub Pages: Settings → Pages → branch `main`, folder `/docs`)*

![The Meshtastic control panel showing the operating mode cards, a live count of nearby WiFi and Bluetooth devices, and a live view of the mesh](docs/assets/img/panel-overview.png)
<sub>The control panel running against its built-in simulated board.</sub>

> **Fork note.** This is the Singapore and Windows adaptation of [saadcaffeine/Meshtastic-GOSHkathmandu](https://github.com/saadcaffeine/Meshtastic-GOSHkathmandu) (Nepal, `NP_865`, macOS/Linux commands), maintained by [Edible Makerspace](https://fablabs.io/labs/ediblemakerspace). The panel and tools are the upstream code with Singapore regions, Windows paths and UTF-8-safe file handling added.

---

## What is this?

[Meshtastic](https://meshtastic.org/) is open-source firmware that turns small, inexpensive LoRa radio boards into a long-range, off-grid mesh network. Nodes pass messages for each other, so no phone signal, WiFi or internet is needed.

Think of it as a **sourdough starter passed hand to hand**: each node keeps a little of the culture and passes it on, so the whole neighbourhood ends up with the same bread, with no central bakery.

### Boards (2)

| Board | Role in this project |
|---|---|
| [Seeed XIAO ESP32S3 + Wio-SX1262 kit](https://wiki.seeedstudio.com/xiao_esp32s3_&_wio_SX1262_kit_for_meshtastic/) | **Primary board.** No screen, USB-C, thumbnail-sized. Use it as a desk node, map reporter or Paxcounter sensor. |
| [Heltec WiFi LoRa 32 V3](https://heltec.org/project/wifi-lora-32-v3/) *(optional)* | Listener / desk node with a screen |

### What's in the repository (4 parts)

| Folder / file | What it is |
|---|---|
| [`panel/`](panel/) | A **web control panel** that runs on the computer the board is plugged into (Windows, Mac, Linux or Raspberry Pi). It switches the board between operating modes and shows a live dashboard: nearby devices (Paxcounter), nodes and signal, packets, battery, channel use and a raw packet log. The **Messages** add-on lets you read and send channel and direct messages. |
| [`tools/radio_check.py`](tools/) and [`tools/paxwatch.py`](tools/) | **Diagnostic scripts**: `radio_check.py` compares two boards' radio settings and listens for each other; `paxwatch.py` prints Paxcounter counts and packet totals in the terminal. |
| [`tools/setup-sg.ps1`](tools/setup-sg.ps1) | **One-shot Windows setup**: finds the COM port, shows the current region, asks for confirmation, then sets `SG_923`, `LONG_FAST`, node names and the UTC+8 time zone. |
| [`docs/`](docs/) | **The guide**, published with GitHub Pages: LoRa for WiFi and Bluetooth users, hardware, Windows setup, first setup, Singapore's SG_923 region, Paxcounter, map reporting, troubleshooting, FAQ and a glossary (12 pages). |

---

## Quick start on Windows (PowerShell)

### 1. Flash the board (5 minutes)

1. Plug the board in with a **USB-C data cable** (charge-only cables won't show a COM port).
2. Open the [Meshtastic Web Flasher](https://flasher.meshtastic.org/) in **Chrome or Edge**, pick **XIAO ESP32S3 + Wio-SX1262**, and flash. Use the same firmware version on every board you want to talk to each other.
3. If the flasher can't see the board: hold **BOOT**, tap **RESET**, release **BOOT**, and try again.

### 2. Install Python and the CLI

```powershell
winget install Python.Python.3.12          # or install from python.org and tick "Add to PATH"
py -m pip install --upgrade "meshtastic[cli]"
```

Close and reopen PowerShell after installing Python. Use `py -m meshtastic …` for every command; it works even if `meshtastic.exe` isn't on your PATH.

### 3. Set the region for Singapore

The radio stays silent until a region is set. Either run the script, which asks before changing anything:

```powershell
git clone https://github.com/EdibleMakerspace/Meshtastic-sg.git
cd Meshtastic-sg\tools
.\setup-sg.ps1
```

or do it by hand:

```powershell
[System.IO.Ports.SerialPort]::GetPortNames()                    # find the port, e.g. COM5
py -m meshtastic --port COM5 --set lora.region SG_923
```

Everything else (the `LONG_FAST` preset, the default channel and key) can stay at its default. The default channel then sits on **917.875 MHz**. Full details: [Getting started](docs/getting-started.md) and [Windows setup](docs/windows-setup.md).

### 4. Run the control panel

```powershell
cd ..\panel
py -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
python server.py --mock            # try it with a simulated board, no hardware needed
python server.py                   # with a real board on USB
```

Open <http://127.0.0.1:8080>. Close the Meshtastic web client and any serial monitor first, because only one program can use a COM port at a time. If PowerShell blocks the activate script, run `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` once. See [`panel/README.md`](panel/README.md) for running it on a Raspberry Pi and on your network.

### 5. Check two boards can hear each other

```powershell
cd ..\tools
py radio_check.py --port COM5      # run once per board; it compares the saved reports
```

*Total: 5 steps.* macOS and Linux users: the same steps work with `python3`, `source venv/bin/activate` and ports like `/dev/ttyACM0`.

---

## New to LoRa? The 60-second version for WiFi and Bluetooth users

| | WiFi | Bluetooth | **LoRa (Meshtastic)** |
|---|---|---|---|
| Typical range | tens of metres | a few metres to tens of metres | **1–10+ km** line of sight, hundreds of metres in a dense city |
| Speed | many Mbit/s | about 1–2 Mbit/s | **about 1 kbit/s** (short text and sensor data only) |
| Needs a router or phone? | yes (access point) | yes (paired device) | **no**: every node relays for the others |
| Frequency in Singapore | 2.4 / 5 GHz | 2.4 GHz | **917–925 MHz** (`SG_923`) |
| Power | high | low | **very low**: days on a small battery |

*Total: 5 comparisons.* The longer explainer: [LoRa for WiFi and Bluetooth users](docs/lora-for-wifi-and-bluetooth-users.md).

---

## Why a food lab runs a radio mesh

[Edible Makerspace (EMS)](https://fablabs.io/labs/ediblemakerspace) is a Singapore community lab for citizen science, DIY biohacking and food-based exploration, founded by Saad Chinoy and Michelle Lai. Its stated aim is to think critically through food prototypes within the Southeast Asian food and agriculture system ([InfoCon DB](https://infocondb.org/presenter/edible-makerspace-ems)). A cheap, open, off-grid radio fits that vision: it lets a kitchen, a rooftop garden and a workshop share small amounts of data without depending on anyone's WiFi, and every layer (firmware, protocol, this guide) is open to inspect and repair.

The same ideas map neatly onto the kitchen:

| Meshtastic idea | Kitchen / fermentation analogy |
|---|---|
| Region (`SG_923`) | The food-safety code: which shelves and how hot an oven you may use |
| Channel slot (1 of 32) | A shelf in a fermentation rack, picked by a hash of the jar's label |
| Channel name + key | The jar label and the lock on the pantry door |
| Mesh relaying | A sourdough starter shared between neighbours |
| Duty cycle | Oven rest time: you can't run it flat out all hour |
| Antenna height | The extractor hood: it matters where it vents |
| Matching firmware versions | Everyone using the same edition of the recipe book |
| Paxcounter | Counting how many people pass a market stall without asking anyone's name |

*Total: 8 analogies.*

### Ideas to extend (proposals, not built yet; 5)

These are suggestions for EMS-style projects, using Meshtastic's built-in modules and existing open projects. None has been built or tested here.

| # | Idea | Builds on |
|---|---|---|
| 1 | **Fermentation-cabinet telemetry**: temperature and humidity from a kombucha / SCOBY or tempeh cabinet, sent over LoRa | Meshtastic's environment-telemetry module with an I²C sensor on the XIAO; EMS's SCOBY biomaterials work ([re:publica talk](https://distributeddesign.eu/?p=13326)) |
| 2 | **Garden and soil nodes**: soil moisture and temperature on a rooftop plot | EMS's [Soil Microscopy workshop](https://peatix.com/event/1717913/view/atom) with the Soil Regeneration Project and GreenCircle Eco-Farm |
| 3 | **Event footfall with Paxcounter**: anonymous counts at a workshop or market, as a citizen-science dataset | This repo's [Paxcounter mode](docs/paxcounter.md); [ESP32-Paxcounter](https://github.com/cyberman54/ESP32-Paxcounter) |
| 4 | **A community enclosure kit**: a vented, rain-shielded 3D-printed case for Singapore's climate | Open designs such as [ikoka-nano](https://github.com/ndoo/ikoka-nano-meshtastic-device) and the enclosure notes on [ndoo.sg](https://ndoo.sg/projects:amateur_radio:meshtastic_in_singapore) |
| 5 | **A shared open dataset on meshmap.net** | The [map-reporting guide](docs/map-reporting-mqtt.md) and [meshmap.net](https://meshmap.net/) |

---

## Singapore community (4 groups)

| Who | What |
|---|---|
| [ndoo.sg](https://ndoo.sg/projects:amateur_radio:meshtastic_in_singapore) (Andrew Yong, N4ISE) | The most detailed Singapore setup notes, a starter config and enclosure ideas |
| [SARTS](https://www.sarts.org.sg/tag/meshtastic/) | Meshtastic talks and a regularly updated Singapore getting-started deck |
| 9V1 Meshtastic Telegram group | Regular local meetups, coordinated through the LPWAN & IoT Interest Group Singapore |
| [Seeed Studio](https://wiki.seeedstudio.com/xiao_esp32s3_&_wio_SX1262_kit_for_meshtastic/) | Maker of the primary board; wiki and hands-on workshops |

---

## Guide contents (12 pages)

- [LoRa for WiFi and Bluetooth users](docs/lora-for-wifi-and-bluetooth-users.md)
- [Hardware: Seeed XIAO ESP32S3 and Heltec V3](docs/hardware.md)
- [Windows setup: Python, COM ports, PowerShell](docs/windows-setup.md)
- [Getting started: flash, set region, send a message](docs/getting-started.md)
- [Singapore: the SG_923 region and frequencies](docs/singapore-sg923.md)
- [Paxcounter: counting nearby devices](docs/paxcounter.md)
- [Putting a node on the public map (MQTT and meshmap.net)](docs/map-reporting-mqtt.md)
- [The control panel](docs/control-panel.md)
- [Troubleshooting](docs/troubleshooting.md)
- [FAQ](docs/faq.md) · [Glossary](docs/glossary.md) · [Links and related projects](docs/resources.md)

---

## Status and honesty notes

- **Singapore and Windows changes are new and not yet confirmed on a real board.** What *was* checked: the frequency maths (`SG_923` LongFast = 917.875 MHz, slot 3 of 32, reproducing the documented Nepal result with the same formula); the panel's `--mock` mode end to end; and a parse and dry run of `setup-sg.ps1`. What still needs you: a flash and a message on real Seeed hardware under Windows. Please [open an issue](https://github.com/EdibleMakerspace/Meshtastic-sg/issues) with what you see.
- The upstream Kathmandu build was tested with a Heltec V3 and two XIAO ESP32S3 boards on firmware 2.5.x. Real-board parts of the panel (mode switching, USB proxy mode) have had limited hardware testing.
- This is a community project and is **not affiliated with Meshtastic LLC, Heltec or Seeed Studio**. Meshtastic® is a registered trademark of Meshtastic LLC.
- **Radio rules:** Meshtastic's `SG_923` region is 917–925 MHz at 20 dBm (100 mW). The secondary sources disagree on the duty-cycle limit (100% in the firmware, 10% in a firmware-repo discussion quoting IMDA), so check the primary document: [IMDA TS SRD](https://www.imda.gov.sg/regulations-and-licensing-listing/ict-standards-and-quality-of-service/telecommunication-and-security-standards/radio-communication-equipment-standards). You are responsible for operating within local regulations. Details: [Singapore: SG_923](docs/singapore-sg923.md#is-it-legal).

## Credits and related projects

- [Meshtastic](https://meshtastic.org/): [firmware](https://github.com/meshtastic/firmware), [Python library and CLI](https://github.com/meshtastic/python), [web client](https://github.com/meshtastic/web), [web flasher](https://github.com/meshtastic/web-flasher), [protobufs](https://github.com/meshtastic/protobufs)
- [saadcaffeine/Meshtastic-GOSHkathmandu](https://github.com/saadcaffeine/Meshtastic-GOSHkathmandu): the Kathmandu original this fork is based on, built with the [GOSH: Gathering for Open Science Hardware](https://openhardware.science/) community
- Singapore sources: [ndoo.sg](https://ndoo.sg/projects:amateur_radio:meshtastic_in_singapore), [SARTS](https://www.sarts.org.sg/tag/meshtastic/)
- [meshmap.net](https://meshmap.net/) by [brianshea2](https://github.com/brianshea2/meshmap.net)
- [RadioLib](https://github.com/jgromes/RadioLib) (the LoRa driver inside Meshtastic) and the [Semtech SX1262](https://www.semtech.com/products/wireless-rf/lora-connect/sx1262) radio chip
- [ESP32-Paxcounter](https://github.com/cyberman54/ESP32-Paxcounter), the original idea behind Meshtastic's Paxcounter module
- [Flask](https://flask.palletsprojects.com/) and [Eclipse Paho MQTT](https://github.com/eclipse-paho/paho.mqtt.python)

## License

Code: [GPL-3.0](LICENSE), matching the Meshtastic Python library it builds on. Guide text and images in `docs/`: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).
Contributions are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md).
