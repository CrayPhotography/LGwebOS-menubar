# LG TV Remote

A native macOS menu bar remote for LG webOS TVs. Launch apps, switch HDMI inputs, navigate with a touchpad, and keep your TV controls a click away.

The app is called **LG TV Remote**. This is a community project, independent of LG.

## Features

- Directional controls, OK, Home, Back, and a mouse-like touchpad.
- Text entry into supported TV text fields.
- Installed apps with bundled icons, brand colors, search, and favorites.
- HDMI inputs with the active input highlighted and listed first.
- Volume, mute, power off, and optional Wake-on-LAN.
- Screen time and most-used apps observed while this Mac is connected.
- Local activity logs, TV information, and picture settings where supported.
- Local media file casting through DLNA, with HTTP range support.
- An AirPlay guide and a shortcut to macOS Displays settings.

## Build and run

Requires macOS 14 or later and Xcode Command Line Tools with Swift 5.9 or later. There are no external Swift dependencies and no Node.js runtime requirement.

```sh
xcode-select --install
bash scripts/build.sh
open "dist/LG TV Remote.app"
```

The script builds in a temporary directory, removes debug symbols, and creates a locally signed app bundle. It does not connect to a TV. Locally built apps are not notarized releases.

## Connect your TV

1. Turn on the TV and connect it to the same local network as your Mac.
2. Open the app from the menu bar, then open Settings.
3. Choose **Find TVs on your network**, or enter the TV's local IPv4 address. You can find it in the TV's network settings.
4. Optionally enter a display name and a MAC address for Wake-on-LAN.
5. Choose **Save and connect**, approve the certificate prompt on your Mac, and accept pairing on the TV.

If macOS asks for Local Network access, allow it. Discovery may not work across guest networks or networks with device isolation; manual IP entry is available.

Pairing uses encrypted WebSocket connections on port 3001. The TV certificate fingerprint and pairing key stay in your Mac's Keychain. A changed certificate is rejected. Use **Forget pairing** in Settings to explicitly pair again after confirming the device.

The project ships with no configured TV address, device name, model, MAC address, or pairing key. Supported addresses are local IPv4 addresses; hostnames and IPv6 are not currently supported.

## Compatibility and limits

Development targeted webOS 5.0. Other models and firmware versions may expose different permissions or behavior.

- **Screen time:** collected locally while the app is running, connected, and the Mac is awake. It cannot retrieve the TV's historical usage.
- **Home status:** the TV may report the underlying app while its Home overlay is visible. Home presses from this app are tracked locally; Home presses from a physical remote may not be detectable.
- **HDMI devices:** switching to a PlayStation or Chromecast controls the TV input. It does not turn the Mac into a console gamepad.
- **Picture settings:** reads and writes depend on TV permissions. Some TVs allow reading values but reject changes.
- **Media casting:** playback depends on the TV's supported codecs and DLNA service. Only the selected file is served, through a temporary URL limited to the TV and loopback connections.
- **AirPlay:** mirroring uses macOS Screen Mirroring and requires an AirPlay-capable TV. The app provides guidance, rather than starting desktop mirroring itself. Capturing the TV screen on the Mac is not implemented.
- **Logs:** activity logs describe this app's connection and commands. Internal TV system logs and Developer Mode access are not included.
- **Wake:** requires the TV's MAC address, a supported standby mode, and network wake enabled on the TV.

## Privacy and local storage

The app has no analytics, account, or cloud service. TV control stays on your local network. Icons are bundled with the app.

Connection preferences and favorites are stored in macOS preferences. Usage and activity history are stored under `~/Library/Application Support/br.local.LGRemote/`. Pairing credentials and certificate pins are stored in Keychain, separately for each TV address. These runtime files are not part of this repository.

Personal investigation records, captures, local configuration, and generated builds are excluded from the source repository.

## Offline checks

```sh
bash scripts/build.sh
"dist/LG TV Remote.app/Contents/MacOS/LGRemote" --self-check
python3 scripts/privacy-check.py
```

The self-check exercises isolated preferences, certificate policy, pointer recovery, Home behavior, usage accounting, packaged resources, and a loopback media server. It does not access saved pairing credentials or a real TV.

The privacy checker scans publication files for local paths, device addresses, persisted pairing keys, and optional identifiers supplied with `--deny TEXT`. It is a review aid, not a guarantee for arbitrary new files.

## Optional diagnostics

Diagnostics require an explicit TV address and do not switch inputs or launch apps. Reports contain local device information: keep them private.

```sh
mkdir -p .local
export TV_IP="your-tv-local-ipv4-address"
"dist/LG TV Remote.app/Contents/MacOS/LGRemote" \
  --diagnose --host "$TV_IP" --report .local/diagnostics.json
```

For a TV without a stored certificate pin, add `--trust-new-tv` to enable the interactive trust prompt. Run `--help` for available options.

## Contributing

Bug reports and improvements are welcome. Use English for code, interface text, documentation, and issues. Include macOS and webOS versions, reproduction steps, and a redacted error message. Keep IP addresses, MAC addresses, serial numbers, pairing keys, and private diagnostic reports out of public issues.

The software is MIT licensed. See [LICENSE](LICENSE) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for third-party material and brand assets.
