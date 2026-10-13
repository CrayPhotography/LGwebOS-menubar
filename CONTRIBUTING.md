# Contributing

Thanks for helping make LG TV Remote better. Bug reports, TV compatibility notes, and pull requests are all welcome.

## Before you open an issue or pull request

- Search existing issues first.
- Remove private data from anything you paste: IP and MAC addresses, the `client-key` value, TV serial numbers, Keychain contents, and log files. The app's own logs and usage journal stay on your Mac, so only share what you need.

## Building locally

Requires macOS 14 or later and Swift 5.9 or later.

```sh
bash scripts/build.sh
```

## Before you send a pull request

Run the privacy check. It scans the files that would be published and fails if it finds local paths, private IPs, MAC addresses, or saved pairing keys:

```sh
python3 scripts/privacy-check.py
```

CI runs the privacy check, app build, and packaged app self-check on every pull request.

## Pull request guidelines

- Keep each pull request focused on one change.
- Say which TV model and webOS version you tested with, if the change touches TV communication.
- Don't add third-party code or assets without a license and an entry in `THIRD_PARTY_NOTICES.md`.
- The project is MIT licensed. By contributing, you agree your changes use the same license.
