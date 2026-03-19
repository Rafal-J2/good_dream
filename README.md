# good_dream

## Android emulator troubleshooting

- Code fix included in recent commits: app launch activity is set to `MainActivity` and `MainActivity` extends `AudioServiceActivity`.
- This fix resolves Android launcher/activity wiring issues and is required for stable app startup.
- A black emulator screen is usually an AVD/GPU rendering issue, not an app logic issue.

Recommended AVD setup:

- Device: Pixel 5 or Pixel 6
- System image: Android 14 or 15 (`x86_64`)
- Graphics: `Software` (or `ANGLE`)
- First run: `Cold Boot`
