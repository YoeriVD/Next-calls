# Task List Selection Feature - User Guide

## Overview

The Next-calls app now allows you to choose which reminder list to use for displaying your calls. This setting is saved and persists across app restarts.

## How to Use

### Accessing Settings

1. Open the Next-calls app
2. Tap the gear icon (⚙️) in the top-right corner of the screen
3. The Settings view will appear

### Selecting a Reminder List

1. In the Settings view, tap on "Reminder List"
2. Choose your preferred list from the available reminder lists
3. The selection is automatically saved
4. Tap "Done" to return to the main view
5. The app will automatically refresh to show calls from your selected list

### Resetting to Default

1. Open Settings (tap the gear icon)
2. Scroll to the bottom
3. Tap "Reset to Default"
4. The list will be reset to "Volgende acties"

## Features

### Persistence
- Your selected list is automatically saved
- The setting persists across app restarts
- No manual saving required

### CarPlay Support
- The selected list is used in both iOS and CarPlay interfaces
- Change the list once, and it applies everywhere
- Seamless experience across devices

### Real-time Updates
- When you change the list selection, the app automatically refreshes
- No need to manually refresh after changing settings
- Instant feedback

### Error Handling
- If the selected list is deleted, you'll be notified
- The app gracefully handles missing lists
- Clear error messages guide you to fix issues

## First Launch Experience

- **Initial State**: The app shows an empty state with a message prompting you to select a list
- **Getting Started**: Tap the "Open Settings" button to choose your reminder list
- **After Selection**: Once you select a list, your calls will appear immediately
- **Persistence**: Your selection is saved and will be used on subsequent launches

## Screenshots

### Main View with Settings Button
```
┌─────────────────────────┐
│ ← Calls            ⚙️   │  ← Settings button here
├─────────────────────────┤
│ > Call John             │
│ > Call Sarah            │
│ > Call Office           │
│                         │
└─────────────────────────┘
```

### Settings View - List Selection
```
┌─────────────────────────┐
│ Settings          Done  │
├─────────────────────────┤
│ TASK LIST               │
│                         │
│ Reminder List       >   │  ← Tap to select
│ Volgende acties         │
│                         │
│ Select which reminder   │
│ list to use for         │
│ displaying calls...     │
├─────────────────────────┤
│                         │
│ [Reset to Default]      │
│                         │
│ Resets the selected     │
│ list to "Volgende..."   │
└─────────────────────────┘
```

### List Picker
```
┌─────────────────────────┐
│ ← Reminder List         │
├─────────────────────────┤
│ ✓ Volgende acties       │  ← Selected list
│   Personal              │
│   Work                  │
│   Shopping              │
│   Family                │
│                         │
└─────────────────────────┘
```

## Technical Details

### Storage
- Settings are stored in UserDefaults
- Key: `selectedReminderList`
- Value: String (list name)

### Synchronization
- Settings automatically sync via iCloud if enabled
- Uses standard UserDefaults syncing
- No custom sync logic required

### Performance
- List fetching happens asynchronously
- UI remains responsive during loading
- Minimal impact on app performance

## Troubleshooting

### "Selected list not found" Error
**Cause**: The list you selected was deleted from Reminders app

**Solution**:
1. Open Settings in Next-calls
2. Select a different list or tap "Reset to Default"
3. The error should resolve

### Settings Not Saving
**Cause**: UserDefaults permissions or storage issue

**Solution**:
1. Restart the app
2. Check device storage
3. Reinstall the app if problem persists

### List Not Appearing in Picker
**Cause**: Reminders permission not granted

**Solution**:
1. Open iOS Settings → Next calls
2. Enable Reminders permission
3. Restart the app

### CarPlay Not Showing Selected List
**Cause**: App state sync issue

**Solution**:
1. Disconnect and reconnect CarPlay
2. Refresh the list in the iOS app
3. CarPlay should sync automatically

## Best Practices

1. **Regular Review**: Periodically review your list selection to ensure it matches your workflow
2. **List Organization**: Keep your reminder lists organized in the Reminders app
3. **Consistent Naming**: Use clear, descriptive names for your reminder lists
4. **Backup**: Your settings are part of your iCloud backup (if enabled)

## Privacy

- List names are stored locally on your device
- No data is sent to external servers
- Settings are part of your standard iOS backup
- Only you can access and modify these settings

## Accessibility

- Settings view is fully accessible with VoiceOver
- Clear labels and hints for all interactive elements
- Supports Dynamic Type for larger text
- Keyboard navigation support

## Support

For issues or questions:
1. Check this guide first
2. Review the IMPLEMENTATION_SUMMARY.md for technical details
3. Check app permissions in iOS Settings
4. Report issues via the GitHub repository
