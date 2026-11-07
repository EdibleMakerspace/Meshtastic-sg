---
title: Hardware for Meshtastic in Singapore - Seeed XIAO ESP32S3 Wio-SX1262 and Heltec V3
description: Choosing and preparing Meshtastic boards for the SG_923 band - the Seeed XIAO ESP32S3 with Wio-SX1262 kit (primary) and the Heltec WiFi LoRa 32 V3 (optional), antennas, 923 MHz variants and power.
---

# Hardware

**This guide is built around the Seeed XIAO ESP32S3 + Wio-SX1262 kit: an ESP32-S3 with a Semtech SX1262 LoRa radio, officially supported by Meshtastic.** The Heltec WiFi LoRa 32 V3 from the Kathmandu version also works and is kept as an optional second board. Browse every supported board on the [Meshtastic devices page](https://meshtastic.org/docs/hardware/devices/).

## The boards

| | **Seeed XIAO ESP32S3 + Wio-SX1262 kit** (primary) | Heltec WiFi LoRa 32 V3 (optional) |
|---|---|---|
| Chip | ESP32-S3 (8 MB flash, 8 MB PSRAM) + SX1262 | ESP32-S3 + SX1262 |
| Screen | none | 0.96″ OLED |
| Size | about a thumbnail (21 × 18 mm core) | about a matchbox |
| Antenna connector | U.FL / IPEX | U.FL / IPEX |
| USB on Windows | native USB, appears as `COMx` (`303A:1001`) | CP210x USB-serial bridge, appears as `COMx`; Windows may need the Silicon Labs CP210x driver |
| Paxcounter capable | yes (ESP32) | yes (ESP32) |
| Meshtastic docs | [Wio-SX1262 + XIAO ESP32S3](https://meshtastic.org/docs/hardware/devices/seeed-studio/wio-series/wio-sx1262s/?wio-sx1262=esp32-s3) | [Heltec LoRa 32](https://meshtastic.org/docs/hardware/devices/heltec-automation/lora32/) |
| Maker page | [Seeed wiki](https://wiki.seeedstudio.com/xiao_esp32s3_&_wio_SX1262_kit_for_meshtastic/) · [shop](https://www.seeedstudio.com/Wio-SX1262-with-XIAO-ESP32S3-p-5982.html) | [heltec.org](https://heltec.org/project/wifi-lora-32-v3/) |

*Total: 2 boards, 9 attributes compared.*

## Buy the right frequency version

Many LoRa boards come in a **low-band** (433 / 470–510 MHz) and a **high-band** (863–928 MHz) version that look almost identical. **Singapore's `SG_923` needs the high-band version.**

- **Seeed Wio-SX1262:** covers 862–930 MHz, so 917–925 MHz is inside its range.
- **Ordering tip from the Singapore community:** choose the 923 MHz option if there is one, otherwise 915 MHz, otherwise 868 MHz. The 868/915/923 boards are the same hardware with different antennas in the box; 433 MHz boards differ and cannot be used on the 900 MHz band ([ndoo.sg](https://ndoo.sg/projects:amateur_radio:meshtastic_in_singapore)).
- **Heltec V3:** on the Kathmandu build the band wasn't printed on the box. Two solder pads marked **HF** and **LF** sit near the radio, with a small resistor bridging one of them; the resistor should be on **HF**.

## Antennas

- **Always attach the antenna before powering on.** Transmitting without an antenna can damage the radio.
- Use an antenna made for **915 MHz or 923 MHz**. A 915 MHz antenna is within about 0.9% of 923 MHz ((923 − 915) / 915), close enough for hobby use. A 433 MHz antenna is much longer and works badly here.
- The U.FL / IPEX connector is tiny: press it straight down until it clicks. A half-seated connector can cost most of your range.
- Height beats power: a node on a rooftop, balcony or window ledge hears far more than one on a desk. In a high-rise city, think of the antenna as the **extractor hood**: it matters more where it vents than how big the fan is.

## Power

- Both boards run from USB-C. The Heltec has a JST connector for a single-cell LiPo battery.
- In the [control panel](control-panel.md), a battery level above 100% means "powered over USB, no battery reading".
- Singapore's heat and humidity are hard on small electronics: keep outdoor nodes in a vented, rain-shielded enclosure. See the [enclosure ideas on ndoo.sg](https://ndoo.sg/projects:amateur_radio:meshtastic_in_singapore).

## Which firmware?

Flash with the [Meshtastic Web Flasher](https://flasher.meshtastic.org/) and choose the exact board (for example the **XIAO ESP32S3 + Wio-SX1262** entry, or **Heltec V3**, not V2). Keep **every board on the same firmware version**. On the Kathmandu build, a Heltec on a newer firmware than the XIAOs could not hear them at all until it was reflashed (see [Troubleshooting](troubleshooting.md)). Release notes are on [GitHub](https://github.com/meshtastic/firmware/releases).

Next: **[Windows setup](windows-setup.md)** →
