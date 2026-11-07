---
title: Meshtastic links, documentation and related projects
description: Official Meshtastic documentation, GitHub repositories, tools, hardware pages, maps and related open-source projects used in this Singapore LoRa mesh guide.
---

# Links and related projects

**Everything this project builds on, with the official sources for each topic.**

## Meshtastic

| What | Link |
|---|---|
| Website and documentation | [meshtastic.org](https://meshtastic.org/) · [Introduction](https://meshtastic.org/docs/introduction/) · [Getting started](https://meshtastic.org/docs/getting-started/) · [FAQ](https://meshtastic.org/docs/faq/) |
| Flashing | [Web Flasher](https://flasher.meshtastic.org/) · [Flashing guide](https://meshtastic.org/docs/getting-started/flashing-firmware/) |
| Web client | [client.meshtastic.org](https://client.meshtastic.org/) |
| Radio settings | [LoRa config](https://meshtastic.org/docs/configuration/radio/lora/) · [Radio settings overview](https://meshtastic.org/docs/overview/radio-settings/) · [Region by country](https://meshtastic.org/docs/configuration/region-by-country/) · [Channels](https://meshtastic.org/docs/configuration/radio/channels/) · [Position](https://meshtastic.org/docs/configuration/radio/position/) |
| Modules | [Paxcounter](https://meshtastic.org/docs/configuration/module/paxcounter/) · [MQTT module](https://meshtastic.org/docs/configuration/module/mqtt/) · [MQTT integration](https://meshtastic.org/docs/software/integrations/mqtt/) |
| How it works | [Mesh algorithm](https://meshtastic.org/docs/overview/mesh-algo/) · [Encryption](https://meshtastic.org/docs/overview/encryption/) |
| Python CLI | [CLI guide](https://meshtastic.org/docs/software/python/cli/) · [Installation](https://meshtastic.org/docs/software/python/cli/installation/) · [PyPI](https://pypi.org/project/meshtastic/) |
| Hardware | [Supported devices](https://meshtastic.org/docs/hardware/devices/) · [Heltec LoRa 32](https://meshtastic.org/docs/hardware/devices/heltec-automation/lora32/) · [Seeed Wio-SX1262 + XIAO ESP32S3](https://meshtastic.org/docs/hardware/devices/seeed-studio/wio-series/wio-sx1262s/?wio-sx1262=esp32-s3) |
| GitHub | [meshtastic](https://github.com/meshtastic) · [firmware](https://github.com/meshtastic/firmware) ([releases](https://github.com/meshtastic/firmware/releases)) · [python](https://github.com/meshtastic/python) · [web](https://github.com/meshtastic/web) · [web-flasher](https://github.com/meshtastic/web-flasher) · [protobufs](https://github.com/meshtastic/protobufs) |

## Singapore regulation and community (6 links)

| What | Link |
|---|---|
| IMDA short-range device standard (TS SRD) | [IMDA radio communication equipment standards](https://www.imda.gov.sg/regulations-and-licensing-listing/ict-standards-and-quality-of-service/telecommunication-and-security-standards/radio-communication-equipment-standards) |
| Meshtastic in Singapore guide | [ndoo.sg](https://ndoo.sg/projects:amateur_radio:meshtastic_in_singapore) (Andrew Yong, N4ISE) |
| SARTS Meshtastic talks | [sarts.org.sg/tag/meshtastic](https://www.sarts.org.sg/tag/meshtastic/) |
| Singapore region discussion on the firmware repo | [meshtastic/firmware PR #2695](https://github.com/meshtastic/firmware/pull/2695) |
| Frequency-plan forum thread (SG_923 vs MY_919) | [Meshtastic forum](https://meshtastic.discourse.group/t/wrong-frequency-plan-for-my-919-and-sg-923/12192) |
| Open DIY node design by a Singapore maker | [ikoka-nano-meshtastic-device](https://github.com/ndoo/ikoka-nano-meshtastic-device) |

## Edible Makerspace (7 references)

[Edible Makerspace (EMS)](https://fablabs.io/labs/ediblemakerspace) is a Singapore-based community lab for citizen science, DIY biohacking and food-based exploration.

| Type | Reference |
|---|---|
| Vision | A multicultural group exploring thinking critically through food prototypes within the Southeast Asian food and agriculture system ([InfoCon DB profile](https://infocondb.org/presenter/edible-makerspace-ems)) |
| People | Founded by Saad Chinoy and Michelle Lai, a member of the TANAH collective ([HKW profile](https://archiv.hkw.de/en/programm/beitragende_hkw/l/michelle_lai.php)) |
| Event | HOPE 2020: [Glow in the (Edible) Dyes](https://infocondb.org/con/hope/hope-2020/glow-in-the-edible-dyes) workshop |
| Event / partners | Live [Soil Microscopy workshop](https://peatix.com/event/1717913/view/atom), 20 Nov 2020, with the Soil Regeneration Project and support from GreenCircle Eco-Farm |
| Event | NTU CCA Singapore [IdeasFest 2023](https://sagg.info/event/ntu-cca-ideasfest-2023-exhibitions-2/), 16–19 Feb 2023: *LaserToast*, lasercut edible materials, courtesy EMS |
| Event | re:publica, [EcoPrints: BioPigments and SCOBY vegan leather](https://distributeddesign.eu/?p=13326) |
| Related | Seeed Studio's hands-on Meshtastic workshop at re:publica: [From Hardware to Mesh](https://www.re-publica.com/de/session/hardware-mesh-prototyping-grid-communication-systems) |

## Maps

- [meshmap.net](https://meshmap.net/), the public node map ([source and requirements](https://github.com/brianshea2/meshmap.net))

## Hardware makers

- Heltec: [WiFi LoRa 32 V3](https://heltec.org/project/wifi-lora-32-v3/)
- Seeed Studio: [XIAO ESP32S3 & Wio-SX1262 kit wiki](https://wiki.seeedstudio.com/xiao_esp32s3_&_wio_SX1262_kit_for_meshtastic/) · [kit in the shop](https://www.seeedstudio.com/Wio-SX1262-with-XIAO-ESP32S3-p-5982.html) · [kit with a 3D-printed case](https://www.seeedstudio.com/XIAO-ESP32S3-for-Meshtastic-LoRa-with-3D-Printed-Enclosure-p-6314.html)
- Semtech: [SX1262 LoRa transceiver](https://www.semtech.com/products/wireless-rf/lora-connect/sx1262)

## Related open-source projects

- [RadioLib](https://github.com/jgromes/RadioLib), the radio driver library Meshtastic uses
- [ESP32-Paxcounter](https://github.com/cyberman54/ESP32-Paxcounter), the original standalone Paxcounter
- [Flask](https://flask.palletsprojects.com/) and [paho-mqtt](https://github.com/eclipse-paho/paho.mqtt.python) ([PyPI](https://pypi.org/project/paho-mqtt/)), used by the control panel

## Background

- [LoRaWAN, from the LoRa Alliance](https://lora-alliance.org/about-lorawan/), to see how it differs from Meshtastic
- [GOSH: Gathering for Open Science Hardware](https://openhardware.science/), the community behind the original Kathmandu guide
- [Kathmandu guide this fork is based on](https://github.com/saadcaffeine/Meshtastic-GOSHkathmandu) (Nepal, `NP_865`)
- [GitHub Pages documentation](https://docs.github.com/en/pages) · [llms.txt](https://llmstxt.org/)
