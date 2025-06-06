# AutoBreak ⏳  
**Smart screen breaks after focused work. A macOS menu bar app for auto lock-and-rest cycles.**

[🇨🇳 中文说明](README_CN.md)

---

## Features
- ⏱️ Countdown timer in the macOS menu bar
- 🔒 Automatically locks the screen when time runs out
- 🔁 Supports continuous and one-time countdown modes
- 🧩 Minimal UI (no Dock icon, menu bar only)
- ⚙️ Custom durations:
  - 10 seconds  
  - 60 seconds (default)  
  - 5 minutes  
  - 15 minutes  
  - 30 minutes  
  - 60 minutes
- 🆔 Version info and GitHub repo link

---

## Use Cases
- 👩‍💻 Stay focused during deep work sessions  
- 🧠 Take regular breaks to reduce mental fatigue  
- 👨‍👩‍👧 Help children manage screen time  
- 🧘 Improve productivity with better rest cycles  

---

## How to Use
1. Launch **AutoBreak** (it runs in the menu bar only)
2. Click the lock icon in the menu bar
3. Select a countdown duration
4. The screen will auto-lock when the timer reaches zero

### Modes
- **Continuous Mode**: Always restarts the 60-second countdown after locking
- **One-time Mode**: Runs once, then stops

---

## Installation
1. Download the latest version from [GitHub Releases](https://github.com/guomengtao/autobreak/releases)
2. Open the `.dmg` file
3. Drag **AutoBreak** to the `Applications` folder
4. Launch and configure from the menu bar

---

## Requirements
- macOS 11 or later  
- Swift 5.5+

---

## Development
- [Changelog](CHANGELOG.md)
- [Development Notes](dev_notes.md)

---

## Troubleshooting
- Ensure AppleScript permission is granted in **System Preferences**
- Check screen sleep settings in **System Settings → Lock Screen**
- Restart the app after changing system permissions

---

## License
MIT License  
Copyright © [guomengtao](https://github.com/guomengtao)