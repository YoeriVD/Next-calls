[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=YoeriVD_Next-calls&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=YoeriVD_Next-calls)


## Next calls

A native iOS app that looks through your reminders and selects only those that are about calls, and makes these available through CarPlay.

### ✨ New: Customizable Reminder List Selection

You can now choose which reminder list to use for your calls! The app requires you to explicitly select a reminder list before use. Simply:
1. On first launch, tap "Open Settings" from the empty state
2. Select your preferred reminder list from the available options
3. Your selection is automatically saved and used in both iOS and CarPlay

**No default list** - You have full control over which list to use, making the app work for any language or workflow!

## Features

- 📱 **iOS Native App** - Built with SwiftUI for modern iOS
- 🚗 **CarPlay Integration** - Access your calls safely while driving
- 📋 **Smart Call Detection** - Automatically identifies call-related reminders
- ⚙️ **Explicit List Selection** - Choose any reminder list (required on first launch!)
- 💾 **Persistent Settings** - Your preferences are saved
- 🔄 **Auto-Refresh** - Real-time updates when settings change
- 📞 **Contact Integration** - Matches reminders with your contacts
- 🔢 **Phone Number Detection** - Recognizes inline phone numbers
- 🌍 **International** - No hardcoded language assumptions

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
- [**Recent Changes**](REMOVE_DEFAULT_LIST_CHANGES.md) - Default list removal details
- [**Final Summary**](FINAL_IMPLEMENTATION_SUMMARY.md) - Complete implementation overview

## Good to know

This is a personal project, it is not published to the store (and might never be). However, it now supports customizable reminder lists, making it more flexible for different workflows!
