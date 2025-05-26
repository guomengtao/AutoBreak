# Countdown Lock Screen

[English](README.md) | [中文](README_CN.md)

A macOS menu bar app that provides a configurable countdown before automatically locking the screen.

## Features
- Runs in the top menu bar
- Does not appear in the dock
- Displays countdown timer with lock icon
- Customizable countdown duration
- One-time mode option
- Automatically locks screen
- Version information display
- GitHub repository link

## Countdown Options
- 10 seconds
- 60 seconds (default)
- 5 minutes
- 15 minutes
- 30 minutes
- 60 minutes

## Usage
- Click on the menu bar to access options
- Select desired countdown time
- Menu closes immediately after selection
- Screen locks automatically when countdown reaches zero

## Modes
- Continuous Mode: Repeats default 60-second countdown
- One-time Mode: Uses selected duration once, then returns to default

## Requirements
- macOS 11+
- Swift 5.5+

## Development
- [Changelog](CHANGELOG.md)
- [Development Notes](dev_notes.md)

## Troubleshooting
- Ensure you have permissions to run AppleScript
- Check system sleep settings
- Manually adjust screen lock settings if needed
