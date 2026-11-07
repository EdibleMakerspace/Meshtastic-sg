---
title: Put a Meshtastic node on meshmap.net with MQTT
description: How to make a Meshtastic node appear on the public map meshmap.net - WiFi, the public MQTT server, uplink, map reporting, OK to MQTT and position precision - with the requirements checklist.
---

# Putting a node on the public map (MQTT and meshmap.net)

**A node shows up on [meshmap.net](https://meshmap.net/) when it publishes its position to Meshtastic's public MQTT server through the default channel, with "OK to MQTT" on and an imprecise (blurred) location.** The map refreshes every minute and drops nodes that haven't sent a position for 8 hours.

## What is MQTT here?

MQTT is a lightweight publish/subscribe messaging protocol. A Meshtastic node with internet access can copy ("uplink") the packets it sees to an MQTT server, where maps and other tools pick them up. Meshtastic runs a public server:

| Setting | Default |
|---|---|
| Server | `mqtt.meshtastic.org` |
| Username / password | `meshdev` / `large4cats` (public, shared by everyone) |
| Root topic | `msh/SG_923` in Singapore (`msh/<REGION>`) |
| Topic for a node's packets | `msh/SG_923/2/e/LongFast/!<nodeid>` |

Docs: [MQTT module settings](https://meshtastic.org/docs/configuration/module/mqtt/) · [MQTT integration](https://meshtastic.org/docs/software/integrations/mqtt/).

## Checklist for meshmap.net

From the [meshmap.net README](https://github.com/brianshea2/meshmap.net):

- [ ] Recent firmware
- [ ] **Default primary channel and key** (LongFast, key `AQ==`)
- [ ] **OK to MQTT** turned on (`lora.config_ok_to_mqtt`)
- [ ] **Position** reporting on, with a fixed position or GPS
- [ ] **Precise location off**: position precision between about 364 m and 23.3 km
- [ ] **MQTT module on** with the default server; **uplink** turned on for the primary channel
- [ ] Internet access: WiFi on the node (2.4 GHz only), or a phone or computer acting as a proxy

## With the CLI

```powershell
# On Windows, run each line as:  py -m meshtastic <arguments>
meshtastic --set network.wifi_enabled true --set network.wifi_ssid "YourWiFi" --set network.wifi_psk "YourPassword"
meshtastic --set bluetooth.enabled false --set paxcounter.enabled false
meshtastic --set mqtt.enabled true --set mqtt.map_reporting_enabled true --set lora.config_ok_to_mqtt true
meshtastic --ch-index 0 --ch-set uplink_enabled true --ch-set module_settings.position_precision 13
meshtastic --setlat 1.35 --setlon 103.82          # a fixed position (example: roughly the middle of Singapore; use your own, blurred)
```

Or click **Map reporter** in the [control panel](control-panel.md). It never touches your WiFi name or password, so set those once with the CLI or the web client.

## Singapore: public map and local MQTT

The Singapore community notes there aren't yet enough nodes to form a full island-wide mesh, so some groups use MQTT as an internet backhaul between isolated nodes ([ndoo.sg](https://ndoo.sg/projects:amateur_radio:meshtastic_in_singapore)). Two things to know:

- A local MQTT server is a **third party**. The community's starter file `SG_923_lucifernet.yaml` (in [ndoo/meshtastic-config-my-sg](https://github.com/ndoo/meshtastic-config-my-sg)) points nodes at an MQTT server run by 9W2LWK. **Read any config file before applying it**, because it changes your node's settings and where it sends data.
- Different regions can't hear each other even through MQTT ([SARTS guide](https://sarts.org.sg/wp/wp-content/uploads/2024/06/getting_started_with_meshtastic_in_singapore.pdf)), so every node you bridge must be on `SG_923`.

## Tips from this project

- **Phone hotspot:** ESP32 boards only see **2.4 GHz** WiFi. On an iPhone, turn on *Maximize Compatibility* in Personal Hotspot.
- **Check it's working:** the control panel watches the node's own topic on the public server and shows "Uplink confirmed" when its messages arrive.
- **Privacy:** a position precision of 13 bits blurs the location to a few kilometres. Don't use full precision for a node at home.
- **USB proxy (experimental):** the panel can forward MQTT through the computer's internet instead of the node's WiFi (`mqtt.proxy_to_client_enabled`). This is less tested.

Next: **[The control panel](control-panel.md)** →
