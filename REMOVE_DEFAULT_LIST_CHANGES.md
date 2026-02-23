# Remove Default List Implementation

## Summary
Removed the default "Volgende acties" list behavior to require users to explicitly select a reminder list before viewing calls.

## Changes Made

### 1. SettingsManager.swift
**Changes:**
- Removed `defaultListName` constant ("Volgende acties")
- Changed initialization to use empty string (`""`) instead of default list name
- Removed `resetToDefault()` method
- Added `hasSelectedList` computed property to check if a list is selected

**Impact:**
- Users will start with no list selected on fresh install
- Existing users with saved list selection will continue to work normally

### 2. ReminderStore.swift
**Changes:**
- Added early return with empty array when `hasSelectedList` is false
- Prevents attempting to fetch reminders when no list is configured

**Impact:**
- No crashes when no list is selected
- Graceful handling of empty list selection

### 3. NextCallList.swift (Main View)
**Changes:**
- Added `@ObservedObject` for `SettingsManager` to monitor list selection
- Wrapped content in `ZStack` to show conditional views
- Added `ContentUnavailableView` for empty state when no list is selected
- Shows helpful message: "Please select a reminder list in Settings to view your calls"
- Includes prominent "Open Settings" button for easy navigation

**Impact:**
- Clear user guidance when app is first launched
- Easy access to Settings to configure the list
- Professional empty state UI using native SwiftUI component

### 4. SettingsView.swift
**Changes:**
- Removed "Reset to Default" button and section
- Added "None" option to the picker (tagged with empty string "")
- Users can now explicitly deselect a list if desired

**Impact:**
- Cleaner settings interface
- Users can choose "None" to deselect current list
- No more confusion about what "default" means

### 5. CarplayList.swift
**Changes:**
- Added check for empty items in `update()` method
- Shows informative message in CarPlay when no list is selected: "No calls available" / "Select a reminder list in Settings"

**Impact:**
- CarPlay gracefully handles no list selection
- Users get clear guidance even in the car interface
- No crashes or blank screens in CarPlay

## User Experience Flow

### First Launch (No List Selected)
1. User opens app
2. Sees empty state with message: "No List Selected"
3. Description: "Please select a reminder list in Settings to view your calls"
4. Prominent "Open Settings" button
5. User taps button → Settings opens
6. User selects a reminder list from picker
7. Returns to main view → calls are displayed

### CarPlay First Use
1. User connects to CarPlay
2. Opens Next Calls app in CarPlay
3. Sees: "No calls available" / "Select a reminder list in Settings"
4. User must use iPhone to configure settings
5. After selection, calls appear in CarPlay normally

## Testing Checklist

- [x] Fresh install shows empty state (not default list)
- [x] Empty state shows clear message
- [x] "Open Settings" button navigates to settings
- [x] Settings shows all available reminder lists
- [x] Settings includes "None" option
- [x] Selecting a list immediately shows calls
- [x] CarPlay handles no list selection without crashing
- [x] CarPlay shows helpful message when no list selected
- [x] No crashes when selectedListName is empty
- [x] Existing users' saved list selection is preserved

## Technical Details

### Property Changes
```swift
// Before
private let defaultListName = "Volgende acties"
self.selectedListName = defaults.string(forKey: selectedListKey) ?? defaultListName

// After
self.selectedListName = defaults.string(forKey: selectedListKey) ?? ""
```

### New Helper Property
```swift
var hasSelectedList: Bool {
    !selectedListName.isEmpty
}
```

### Empty State Implementation
Uses SwiftUI's `ContentUnavailableView` (iOS 17+):
```swift
ContentUnavailableView {
    Label("No List Selected", systemImage: "list.bullet.clipboard")
} description: {
    Text("Please select a reminder list in Settings to view your calls")
} actions: {
    Button("Open Settings") { showingSettings = true }
}
```

## Backward Compatibility

**Existing Users:**
- Users who already have a list selected will see no change
- Their saved selection is preserved in UserDefaults
- App continues to work normally

**New Users:**
- Must explicitly select a list on first use
- Clear onboarding experience via empty state
- No assumptions about list names

## Benefits

1. **No Assumptions**: App doesn't assume list names or language
2. **International**: Works for any language/region without hardcoded Dutch list name
3. **Explicit**: Users know exactly which list they're using
4. **Flexible**: Users can change or deselect lists easily
5. **Clear UX**: Professional empty states guide users
6. **Safe**: No crashes when list is not configured
7. **CarPlay Safe**: Proper handling in vehicle interface

## Files Modified
- `Next calls/Data/SettingsManager.swift`
- `Next calls/Data/ReminderStore.swift`
- `Next calls/Views/NextCallList.swift`
- `Next calls/Views/SettingsView.swift`
- `Next calls/CarPlay/CarplayList.swift`

## Lines of Code
- **Added:** ~30 lines (empty state UI, guard clauses)
- **Removed:** ~15 lines (default value, reset button)
- **Modified:** ~10 lines (initialization, picker options)
