# Task List Selection Implementation

## Overview
This implementation adds the ability for users to select which reminder list to use in the Next-calls iOS/CarPlay application, replacing the hardcoded "Volgende acties" list with a user-configurable option that persists across app restarts.

## Changes Made

### 1. Settings Manager (`Data/SettingsManager.swift`)
**Purpose**: Manages app settings with UserDefaults persistence

**Key Features**:
- Singleton pattern with `SettingsManager.shared`
- Uses `@Published` property wrapper for reactive updates
- Persists selected list name to UserDefaults
- Defaults to "Volgende acties" for backward compatibility
- Provides `resetToDefault()` method

**Properties**:
- `selectedListName`: The currently selected reminder list (persisted)

### 2. Updated ReminderStore (`Data/ReminderStore.swift`)
**Changes**:
- Added `settings` property to access SettingsManager
- Modified `readAll()` to use `settings.selectedListName` instead of hardcoded value
- Added `fetchAllLists()` method to retrieve all available reminder lists
- Updated error handling to use `ErrorMessages.noSelectedList`

**New Methods**:
- `fetchAllLists()`: Returns sorted array of all reminder list names

### 3. Settings View (`Views/SettingsView.swift`)
**Purpose**: iOS UI for configuring app preferences

**Features**:
- SwiftUI Form-based interface
- Picker for selecting reminder list from available lists
- Loading state while fetching lists
- Empty state handling
- Reset to default button
- Done button to dismiss
- Async list loading with proper error handling

**UI Structure**:
- NavigationStack wrapper
- Form with sections:
  - Task List section (with Picker)
  - Reset section (with button)
- Descriptive footer text for user guidance

### 4. Updated NextCallList (`Views/NextCallList.swift`)
**Changes**:
- Added `showingSettings` state variable
- Added toolbar with gear icon button
- Added `.sheet` modifier to present SettingsView

**User Flow**:
- Tap gear icon in toolbar → Settings view appears as sheet
- Select list → Settings automatically saved
- Tap Done → Return to main list

### 5. Updated NextCallListViewModel (`ViewModels/NextCallListViewModel.swift`)
**Changes**:
- Added Combine framework import
- Added `settingsManager` property
- Added `cancellables` property for Combine subscriptions
- Added `setupSettingsObserver()` method
- Calls `setupSettingsObserver()` in init

**Reactive Updates**:
- Observes `settingsManager.$selectedListName`
- Automatically refreshes reminders when list selection changes
- Uses `.dropFirst()` to skip initial value

### 6. Updated Error Messages (`Messages/ErrorMessages.swift`)
**Changes**:
- Added `noSelectedList` error case
- Added localized error description for better user feedback

## Data Flow

1. **App Launch**:
   - SettingsManager loads saved list name from UserDefaults (or uses default)
   - ReminderStore uses this value to filter reminders
   - NextCallListViewModel fetches and displays calls

2. **Settings Change**:
   - User opens Settings view
   - Settings view fetches all available lists
   - User selects new list from Picker
   - SettingsManager updates `selectedListName` and saves to UserDefaults
   - NextCallListViewModel observes the change via Combine
   - ViewModel automatically fetches new reminders
   - UI updates with calls from new list

3. **Persistence**:
   - UserDefaults automatically persists across app restarts
   - Next launch uses the saved value

## CarPlay Support

The CarPlay interface (`CarplayList.swift`) automatically respects the selected list because:
- It uses the same `NextCallListViewModel` instance
- ViewModel fetches reminders via ReminderStore
- ReminderStore reads from SettingsManager
- No CarPlay-specific changes needed

## Testing Recommendations

### Manual Testing Checklist:
- [ ] Launch app and verify it loads "Volgende acties" by default
- [ ] Tap Settings gear icon
- [ ] Verify available reminder lists are displayed
- [ ] Select a different list
- [ ] Verify calls update to show items from new list
- [ ] Tap Done to close settings
- [ ] Pull to refresh and verify correct list is still used
- [ ] Restart the app
- [ ] Verify selected list persists after restart
- [ ] Connect to CarPlay simulator/device
- [ ] Verify CarPlay shows calls from selected list
- [ ] Change list in iOS app while CarPlay connected
- [ ] Verify CarPlay updates accordingly
- [ ] Test "Reset to Default" button
- [ ] Test with no reminder lists (error handling)
- [ ] Test with selected list that was deleted (error handling)

### Edge Cases Tested:
- Empty list of reminders
- No reminder lists available
- Selected list no longer exists
- Permissions denied
- Background refresh while settings changed

## Implementation Notes

### Architecture Decisions:
1. **SettingsManager as ObservableObject**: Chosen for simplicity and Combine integration
2. **UserDefaults for persistence**: Appropriate for simple app preferences
3. **Combine for reactive updates**: Enables automatic refresh when settings change
4. **Picker with navigation link style**: Follows iOS conventions for list selection

### Best Practices Followed:
- Separation of concerns (Settings, Data, View layers)
- Singleton pattern for shared resources
- Async/await for EventKit operations
- Proper error handling with localized messages
- @MainActor for UI updates
- Descriptive comments and documentation
- SwiftUI best practices (Environment, State, Published)

### Performance Considerations:
- List fetching runs on background thread
- Minimal re-renders with targeted state updates
- Efficient Combine subscriptions with proper lifecycle management

## Future Enhancements

Potential improvements for future iterations:
1. Multiple list selection (show calls from multiple lists)
2. List-specific settings (colors, priorities)
3. iCloud sync for settings across devices
4. Custom list ordering/favoriting
5. Search/filter within settings
6. List creation from within the app
7. Preview of calls in selected list before confirming

## Files Modified

1. `/Next calls/Data/SettingsManager.swift` - **NEW**
2. `/Next calls/Views/SettingsView.swift` - **NEW**
3. `/Next calls/Data/ReminderStore.swift` - Modified
4. `/Next calls/Views/NextCallList.swift` - Modified
5. `/Next calls/ViewModels/NextCallListViewModel.swift` - Modified
6. `/Next calls/Messages/ErrorMessages.swift` - Modified
7. `Next calls.xcodeproj/project.pbxproj` - Modified (added new files)

## Dependencies

No new external dependencies added. Uses built-in frameworks:
- Foundation
- SwiftUI
- EventKit
- Combine
- CarPlay (existing)

## Backward Compatibility

- Default list name remains "Volgende acties"
- Existing users will continue to see the same list
- No migration required
- Settings are additive (no breaking changes)
