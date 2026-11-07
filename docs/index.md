---
title: Meshtastic LoRa mesh for Singapore (Windows)
description: A beginner-friendly guide to Meshtastic LoRa mesh radios in Singapore (SG_923, 917-925 MHz) on Windows, with an open-source web control panel for the Seeed XIAO ESP32S3 and Heltec V3 boards.
---

# Meshtastic LoRa mesh for Singapore

**This guide shows how to build a small off-grid LoRa mesh network with [Meshtastic](https://meshtastic.org/) in Singapore, using inexpensive ESP32 boards on the `SG_923` (917–925 MHz) region, from a Windows PC.** It is written for makers, hobbyists and citizen scientists, and for people who already understand WiFi and Bluetooth but have never used LoRa.

It comes with an open-source **web control panel** that runs on a Windows laptop (or Mac, Linux, Raspberry Pi). The panel switches a board between operating modes (map reporter, Paxcounter sensor, listener) and shows live signal, packets and device counts.

![Control panel overview](assets/img/panel-overview.png)

## Start here (4 pages)

1. **[LoRa for WiFi and Bluetooth users](lora-for-wifi-and-bluetooth-users.md)**: what's different and why it matters.
2. **[Hardware](hardware.md)**: the Seeed XIAO ESP32S3 + Wio-SX1262 kit, the optional Heltec V3, plus antennas.
3. **[Windows setup](windows-setup.md)**: Python, COM ports and PowerShell, in ten minutes.
4. **[Getting started](getting-started.md)**: flash, set the region, send your first message.

Then read **[Singapore: SG_923](singapore-sg923.md)** for the frequencies, where 917.875 MHz comes from, and what the regulatory sources say.

## Do more (3 pages)

- **[Paxcounter](paxcounter.md)**: count nearby phones and laptops (WiFi and Bluetooth) and send the totals over LoRa.
- **[Map reporting](map-reporting-mqtt.md)**: put a node on [meshmap.net](https://meshmap.net/) through MQTT.
- **[The control panel](control-panel.md)**: a live dashboard and mode switcher for a USB-connected board.

## When things go wrong

- **[Troubleshooting](troubleshooting.md)**: real problems, including a board that could not hear anyone, and how the cause was found.
- **[FAQ](faq.md)** · **[Glossary](glossary.md)** · **[Links and related projects](resources.md)**

## About

A Singapore and Windows adaptation of the [Kathmandu guide](https://github.com/saadcaffeine/Meshtastic-GOSHkathmandu) by saadcaffeine, maintained by [Edible Makerspace](https://fablabs.io/labs/ediblemakerspace), a Singapore community lab for citizen science and food-based exploration. The code is on [GitHub](https://github.com/EdibleMakerspace/Meshtastic-sg) under GPL-3.0; the guide is CC BY-SA 4.0.
Not affiliated with Meshtastic LLC, Heltec or Seeed Studio.
