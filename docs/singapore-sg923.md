---
title: Meshtastic in Singapore - the SG_923 region, 917-925 MHz and the LongFast frequency
description: Which frequencies Meshtastic uses in Singapore. The SG_923 region covers 917.0-925.0 MHz at up to 20 dBm; the default LongFast channel sits on 917.875 MHz (slot 3 of 32). Includes the regulatory sources and where they disagree.
---

# Singapore: the SG_923 region

**In Singapore, Meshtastic uses the `SG_923` region: 917.0–925.0 MHz, with a firmware power limit of 20 dBm (100 mW).** With the default `LONG_FAST` preset and the default channel, every node transmits and listens on **917.875 MHz**.

> **Kitchen analogy:** the region is your kitchen's food-safety code. It decides which shelves (frequencies) you may use and how hot (how much power) you may run the oven. Every cook in the same kitchen must follow the same code, or nobody can taste each other's dishes.

## Region details

| Property | Value |
|---|---|
| Region code | `SG_923` |
| Frequency range | 917.0 – 925.0 MHz (8 MHz wide) |
| Firmware power limit | 20 dBm = 100 mW (the SX1262 can do about 22 dBm; the firmware caps it for this region) |
| Firmware duty-cycle setting | 100% (see [Is it legal?](#is-it-legal) for a conflicting reading) |
| Default preset | `LONG_FAST` (250 kHz bandwidth, spreading factor 11) |
| Channel slots with LONG_FAST | 32 × 250 kHz |
| Default LongFast frequency | **917.875 MHz** (slot 3 of 32) |

*Total: 7 properties.* Sources: Meshtastic's [LoRa configuration](https://meshtastic.org/docs/configuration/radio/lora/) and [region by country](https://meshtastic.org/docs/configuration/region-by-country/) pages, and the region table in the [firmware source](https://github.com/meshtastic/firmware).

## How is the frequency chosen?

Think of the band as a **fermentation rack with 32 shelves**, each shelf 250 kHz wide. Meshtastic hashes the **channel name** (for the default channel, the preset's name, `LongFast`) to pick one shelf, unless you set `lora.channel_num` or `lora.override_frequency` yourself:

```
slots     = (925.0 − 917.0) MHz / 0.250 MHz = 32
slot      = djb2("LongFast") mod 32          = 3
frequency = 917.0 + 0.125 + 3 × 0.250        = 917.875 MHz
```

This is the same formula the Kathmandu version documented for `NP_865` (there it gave slot 11 of 12, 867.875 MHz). I re-ran the calculation with [`tools/radio_check.py`](https://github.com/EdibleMakerspace/Meshtastic-sg/tree/main/tools): it reproduces the Nepal result and gives **917.875 MHz** for Singapore, the same value a [Meshtastic forum report](https://meshtastic.discourse.group/t/wrong-frequency-plan-for-my-919-and-sg-923/12192) shows for `SG_923`.

When a board boots, its serial log shows the result, for example `Radio freq=917.875 … region=SG_923, name=LongFast … ch=3`. If two of your boards show different frequencies, they will never hear each other.

| Preset (default channel name) | Bandwidth | Slots in SG_923 | Slot | Frequency |
|---|---|---|---|---|
| `LONG_FAST` (LongFast) | 250 kHz | 32 | 3 | **917.875 MHz** |
| `MEDIUM_FAST` (MediumFast) | 250 kHz | 32 | 20 | 922.125 MHz |

*Total: 2 presets shown.* Most people only ever use `LONG_FAST`.

## Neighbouring regions don't mix

Regions are separate "kitchens". Nodes set to different regions cannot talk to each other, even over MQTT bridging, according to the [SARTS Singapore guide](https://sarts.org.sg/wp/wp-content/uploads/2024/06/getting_started_with_meshtastic_in_singapore.pdf).

| Region | Range (MHz) | LongFast frequency | Hears `SG_923` nodes? |
|---|---|---|---|
| `SG_923` (Singapore) | 917.0 – 925.0 | 917.875 | yes, same region |
| `MY_919` (Malaysia) | 919.0 – 924.0 | 922.875 | no: different slot layout |
| `TH` (Thailand) | 920.0 – 925.0 | 923.875 | no: different slot layout |

*Total: 3 regions compared.* If you carry a board across the Causeway, check its region first. The `MY_919` and `TH` values use the same formula (20 slots each, slot 15); the `MY_919` result matches the same forum report.

## A note on 917–920 MHz

The bottom of the band, 917–920 MHz, was added when IMDA revised its short-range device standard (effective 1 September 2023); before that the band was 920–925 MHz ([IB Lenhardt summary](https://ib-lenhardt.com/news/the-imda-updates-it-039-s-the-imda-ts-srd-august-2-2021)). The default LongFast slot (917.875 MHz) sits in that newer part, so **old guides that say "920–925 MHz" for Singapore are out of date**.

## Is it legal?

**Short answer: stay on the firmware defaults and check the primary source yourself.** I could not open IMDA's own standard from here, and the secondary sources I found state *different* limits:

| Source | What it says about ~917–925 MHz |
|---|---|
| Meshtastic region table | 917–925 MHz, 20 dBm, 100% duty cycle |
| [SARTS "Getting started with Meshtastic in Singapore"](https://sarts.org.sg/wp/wp-content/uploads/2024/06/getting_started_with_meshtastic_in_singapore.pdf) (Andrew Yong, N4ISE, May 2024) | 917–925 MHz at 100 mW |
| [Meshtastic firmware PR #2695](https://github.com/meshtastic/firmware/pull/2695) discussion, quoting IMDA TS SRD item 30b | 10% duty cycle, 500 mW EIRP (27 dBm) |

*Total: 3 sources, 3 different statements.*

What this means in practice:

- The firmware default of **20 dBm (100 mW) is at or below every figure above**, so don't raise the power.
- If the 10% duty-cycle reading is the right one, your transmit budget is **6 minutes per hour** (10% × 3600 s = 360 s). Keep position, telemetry and Paxcounter intervals modest, like a sourdough starter: feed it on a schedule, don't keep opening the jar.
- Read the current rules: [IMDA TS SRD (radio communication equipment standards)](https://www.imda.gov.sg/regulations-and-licensing-listing/ict-standards-and-quality-of-service/telecommunication-and-security-standards/radio-communication-equipment-standards).

This page is not legal advice.

## Singapore time zone

Singapore is UTC+8 all year with no daylight saving, so the time-zone string is `<+08>-8`. See [Getting started](getting-started.md#5-name-the-node-and-set-the-time-zone-optional).

## Local community and prior art

| Who / what | Why it helps |
|---|---|
| [ndoo.sg: Meshtastic in Singapore](https://ndoo.sg/projects:amateur_radio:meshtastic_in_singapore) (Andrew Yong, N4ISE) | Region choice, ordering tips, MQTT background, enclosure ideas |
| [SARTS: Getting started with Meshtastic](https://www.sarts.org.sg/tag/meshtastic/) | Slide deck from the May 2024 quarterly meeting; updated regularly |
| 9V1 Meshtastic Telegram group | Regular meetups; coordinated through the LPWAN & IoT Interest Group Singapore, which is independent of SARTS |
| [ikoka-nano-meshtastic-device](https://github.com/ndoo/ikoka-nano-meshtastic-device) (ndoo) | An open DIY node design on the Seeed XIAO nRF52840 and an EBYTE E22 radio: good repurposing material |

*Total: 4 local references.*

Next: **[Paxcounter](paxcounter.md)** →
