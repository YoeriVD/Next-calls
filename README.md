[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=YoeriVD_Next-calls&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=YoeriVD_Next-calls)


## Next calls

A native iOS app that looks through your reminders and selects only those that are about calls, and makes these available through CarPlay.

### ✨ New: Customizable Reminder List Selection

You can now choose which reminder list to use for your calls! The app no longer requires a hardcoded list name. Simply:
1. Tap the ⚙️ Settings button in the app
2. Select your preferred reminder list
3. Your selection is automatically saved and used in both iOS and CarPlay

The default list is still "Volgende acties" for backward compatibility.

## Features

- 📱 **iOS Native App** - Built with SwiftUI for modern iOS
- 🚗 **CarPlay Integration** - Access your calls safely while driving
- 📋 **Smart Call Detection** - Automatically identifies call-related reminders
- ⚙️ **Customizable Lists** - Choose any reminder list (new!)
- 💾 **Persistent Settings** - Your preferences are saved
- 🔄 **Auto-Refresh** - Real-time updates when settings change
- 📞 **Contact Integration** - Matches reminders with your contacts
- 🔢 **Phone Number Detection** - Recognizes inline phone numbers

## Requirements

- iOS 17.0 or later
- Reminders app permission
- Contacts app permission (optional, for contact matching)
- CarPlay-compatible vehicle (optional)

## Setup

1. Clone the repository
2. Open `Next calls.xcodeproj` in Xcode
3. Build and run on your iOS device or simulator
4. Grant Reminders and Contacts permissions when prompted
5. Configure your preferred reminder list in Settings

## Documentation

- [**Feature Guide**](FEATURE_GUIDE.md) - User guide with usage instructions
- [**Implementation Summary**](IMPLEMENTATION_SUMMARY.md) - Technical documentation
- [**Test Plan**](TEST_PLAN.md) - Comprehensive testing guide

## Good to know

This is a personal project, it is not published to the store (and might never be). However, it now supports customizable reminder lists, making it more flexible for different workflows!
