---
title: Meshtastic and LoRa FAQ for Singapore
description: Short answers about Meshtastic and LoRa in Singapore - frequency (SG_923, 917.875 MHz), Windows setup, range, LoRa vs WiFi, Bluetooth and LoRaWAN, nodes that can't hear each other, Paxcounter, meshmap.net and privacy.
---

# FAQ

**Short, direct answers to the questions people ask most about Meshtastic and LoRa in Singapore.** Each links to a longer page.

## What is Meshtastic?

Meshtastic is free, open-source firmware that turns inexpensive LoRa radio boards into an off-grid mesh network for text messages, positions and sensor data, with no phone signal, WiFi or internet needed. See [meshtastic.org](https://meshtastic.org/).

More: [LoRa for WiFi and Bluetooth users](lora-for-wifi-and-bluetooth-users.md)

## Which frequency does Meshtastic use in Singapore?

Singapore uses the SG_923 region: 917.0–925.0 MHz, with a firmware power limit of 20 dBm (100 mW). With the default LongFast preset and channel, nodes use 917.875 MHz.

More: [Singapore: SG_923](singapore-sg923.md)

## How far can Meshtastic LoRa reach?

Typically 1–10 km or more with a clear line of sight between elevated nodes, and hundreds of metres to a few kilometres in a dense, high-rise city like Singapore. Height and a good 915/923 MHz antenna matter more than transmit power.

More: [Hardware](hardware.md)

## How is LoRa different from WiFi and Bluetooth?

LoRa sends very little data (about 1 kbit/s on LongFast) but reaches kilometres using little power, on sub-GHz frequencies (917–925 MHz in Singapore). WiFi and Bluetooth are fast but short-range on 2.4 GHz. Meshtastic nodes relay for each other, so no router is needed.

More: [LoRa for WiFi and Bluetooth users](lora-for-wifi-and-bluetooth-users.md)

## Is Meshtastic the same as LoRaWAN?

No. LoRaWAN is an operator network where sensors talk to gateways. Meshtastic uses the same LoRa radios with its own peer-to-peer mesh protocol and no gateways.

More: [LoRa for WiFi and Bluetooth users](lora-for-wifi-and-bluetooth-users.md)

## Why can't my Meshtastic node see other nodes?

Check that all nodes share the same region (SG_923), preset (LONG_FAST), channel name and key; that the antenna is attached and made for 915/923 MHz; and that all boards run the same firmware version. On the Kathmandu build this guide is based on, a Heltec V3 on firmware 2.7.26 could not hear XIAO boards on 2.5.2 until it was reflashed to match.

More: [Troubleshooting](troubleshooting.md)

## Do I need internet for Meshtastic?

No. Messages travel radio to radio. Internet is only needed for optional extras like MQTT and the public map meshmap.net.

More: [Map reporting and MQTT](map-reporting-mqtt.md)

## What is the Meshtastic Paxcounter?

A module for ESP32 boards that counts nearby WiFi and Bluetooth devices and broadcasts the counts over LoRa. WiFi and Bluetooth must be turned off on that node because the module uses them to scan.

More: [Paxcounter](paxcounter.md)

## How do I get my node on meshmap.net?

Use the default primary channel and key, turn on OK to MQTT, enable the MQTT module with the default server mqtt.meshtastic.org, enable uplink on the primary channel, share a position with precise location off (between about 364 m and 23.3 km), and give the node internet access.

More: [Map reporting and MQTT](map-reporting-mqtt.md)

## Which boards work well for Meshtastic in Singapore?

This project is built around the Seeed XIAO ESP32S3 with Wio-SX1262 kit and also works with the Heltec WiFi LoRa 32 V3; both are ESP32-S3 + SX1262 boards. Buy the 923 MHz version if offered, otherwise 915 MHz (both are 863–928 MHz high-band).

More: [Hardware](hardware.md)

## Are Meshtastic messages private?

Channel messages are encrypted with the channel key, but the default channel's key is public, so treat it as a public room. Since firmware 2.5, direct messages use public-key encryption. Use a private channel with your own key for group privacy.

More: [LoRa for WiFi and Bluetooth users](lora-for-wifi-and-bluetooth-users.md)

## What does SNR mean in Meshtastic?

Signal-to-noise ratio in dB. LoRa can decode signals below the noise floor, so negative SNR is normal; on LongFast packets still decode down to roughly −15 dB.

More: [The control panel](control-panel.md)

## Is Meshtastic legal to use in Singapore?

Meshtastic's SG_923 region follows the 917–925 MHz short-range-device band with a 20 dBm (100 mW) firmware limit, but the sources disagree on the duty-cycle limit (100% versus 10%), so stay on the defaults and check IMDA's current standard. This is not legal advice.

More: [Singapore: SG_923, Is it legal?](singapore-sg923.md#is-it-legal)

## Can I set this up on Windows?

Yes. Install Python with the py launcher, use a USB data cable, flash with the web flasher in Chrome or Edge, and run every command as py -m meshtastic. The Seeed XIAO ESP32S3 appears as a COM port using the driver Windows already includes.

More: [Windows setup](windows-setup.md)

<script type="application/ld+json">
{
 "@context": "https://schema.org",
 "@type": "FAQPage",
 "mainEntity": [
  {
   "@type": "Question",
   "name": "What is Meshtastic?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "Meshtastic is free, open-source firmware that turns inexpensive LoRa radio boards into an off-grid mesh network for text messages, positions and sensor data, with no phone signal, WiFi or internet needed. See https://meshtastic.org/."
   }
  },
  {
   "@type": "Question",
   "name": "Which frequency does Meshtastic use in Singapore?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "Singapore uses the SG_923 region: 917.0–925.0 MHz, with a firmware power limit of 20 dBm (100 mW). With the default LongFast preset and channel, nodes use 917.875 MHz."
   }
  },
  {
   "@type": "Question",
   "name": "How far can Meshtastic LoRa reach?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "Typically 1–10 km or more with a clear line of sight between elevated nodes, and hundreds of metres to a few kilometres in a dense, high-rise city like Singapore. Height and a good 915/923 MHz antenna matter more than transmit power."
   }
  },
  {
   "@type": "Question",
   "name": "How is LoRa different from WiFi and Bluetooth?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "LoRa sends very little data (about 1 kbit/s on LongFast) but reaches kilometres using little power, on sub-GHz frequencies (917–925 MHz in Singapore). WiFi and Bluetooth are fast but short-range on 2.4 GHz. Meshtastic nodes relay for each other, so no router is needed."
   }
  },
  {
   "@type": "Question",
   "name": "Is Meshtastic the same as LoRaWAN?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "No. LoRaWAN is an operator network where sensors talk to gateways. Meshtastic uses the same LoRa radios with its own peer-to-peer mesh protocol and no gateways."
   }
  },
  {
   "@type": "Question",
   "name": "Why can't my Meshtastic node see other nodes?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "Check that all nodes share the same region (SG_923), preset (LONG_FAST), channel name and key; that the antenna is attached and made for 915/923 MHz; and that all boards run the same firmware version. On the Kathmandu build this guide is based on, a Heltec V3 on firmware 2.7.26 could not hear XIAO boards on 2.5.2 until it was reflashed to match."
   }
  },
  {
   "@type": "Question",
   "name": "Do I need internet for Meshtastic?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "No. Messages travel radio to radio. Internet is only needed for optional extras like MQTT and the public map meshmap.net."
   }
  },
  {
   "@type": "Question",
   "name": "What is the Meshtastic Paxcounter?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "A module for ESP32 boards that counts nearby WiFi and Bluetooth devices and broadcasts the counts over LoRa. WiFi and Bluetooth must be turned off on that node because the module uses them to scan."
   }
  },
  {
   "@type": "Question",
   "name": "How do I get my node on meshmap.net?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "Use the default primary channel and key, turn on OK to MQTT, enable the MQTT module with the default server mqtt.meshtastic.org, enable uplink on the primary channel, share a position with precise location off (between about 364 m and 23.3 km), and give the node internet access."
   }
  },
  {
   "@type": "Question",
   "name": "Which boards work well for Meshtastic in Singapore?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "This project is built around the Seeed XIAO ESP32S3 with Wio-SX1262 kit and also works with the Heltec WiFi LoRa 32 V3; both are ESP32-S3 + SX1262 boards. Buy the 923 MHz version if offered, otherwise 915 MHz (both are 863–928 MHz high-band)."
   }
  },
  {
   "@type": "Question",
   "name": "Are Meshtastic messages private?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "Channel messages are encrypted with the channel key, but the default channel's key is public, so treat it as a public room. Since firmware 2.5, direct messages use public-key encryption. Use a private channel with your own key for group privacy."
   }
  },
  {
   "@type": "Question",
   "name": "What does SNR mean in Meshtastic?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "Signal-to-noise ratio in dB. LoRa can decode signals below the noise floor, so negative SNR is normal; on LongFast packets still decode down to roughly −15 dB."
   }
  },
  {
   "@type": "Question",
   "name": "Is Meshtastic legal to use in Singapore?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "Meshtastic's SG_923 region follows the 917–925 MHz short-range-device band with a 20 dBm (100 mW) firmware limit, but the sources disagree on the duty-cycle limit (100% versus 10%), so stay on the defaults and check IMDA's current standard. This is not legal advice."
   }
  },
  {
   "@type": "Question",
   "name": "Can I set this up on Windows?",
   "acceptedAnswer": {
    "@type": "Answer",
    "text": "Yes. Install Python with the py launcher, use a USB data cable, flash with the web flasher in Chrome or Edge, and run every command as py -m meshtastic. The Seeed XIAO ESP32S3 appears as a COM port using the driver Windows already includes."
   }
  }
 ]
}
</script>
