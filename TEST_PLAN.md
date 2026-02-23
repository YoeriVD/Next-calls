# Task List Selection - Test Plan

## Test Environment Setup

### Prerequisites
- iOS device or simulator running iOS 17.0 or later
- Xcode 15.0 or later
- Multiple reminder lists created in the Reminders app
- At least one list named "Volgende acties" for default behavior testing
- CarPlay simulator or compatible vehicle for CarPlay testing

### Test Data Setup

Create the following reminder lists in the Reminders app:
1. **Volgende acties** - Default list (with some test reminders)
2. **Personal** - Alternative list with personal call reminders
3. **Work** - Work-related call reminders
4. **Test Empty** - Empty list (no reminders)

Each list should contain reminders with:
- Names (e.g., "Call John")
- Phone numbers (e.g., "Call +32 477 40 30 40")
- Mix of both

## Unit Tests

### SettingsManager Tests

#### Test 1: Default Value
**Objective**: Verify default list name is "Volgende acties"
```swift
func testDefaultListName() {
    let settings = SettingsManager()
    XCTAssertEqual(settings.selectedListName, "Volgende acties")
}
```

#### Test 2: Persistence
**Objective**: Verify settings persist across instances
```swift
func testPersistence() {
    let settings1 = SettingsManager.shared
    settings1.selectedListName = "Work"
    
    let settings2 = SettingsManager.shared
    XCTAssertEqual(settings2.selectedListName, "Work")
}
```

#### Test 3: Reset to Default
**Objective**: Verify reset functionality
```swift
func testResetToDefault() {
    let settings = SettingsManager.shared
    settings.selectedListName = "Personal"
    settings.resetToDefault()
    XCTAssertEqual(settings.selectedListName, "Volgende acties")
}
```

### ReminderStore Tests

#### Test 4: Fetch All Lists
**Objective**: Verify all reminder lists are retrieved
```swift
func testFetchAllLists() async throws {
    let store = ReminderStore.shared
    try await store.requestAccess()
    let lists = store.fetchAllLists()
    XCTAssertGreaterThan(lists.count, 0)
    XCTAssertEqual(lists, lists.sorted())
}
```

#### Test 5: Filter by Selected List
**Objective**: Verify reminders are filtered by selected list
```swift
func testFilterBySelectedList() async throws {
    let settings = SettingsManager.shared
    settings.selectedListName = "Personal"
    
    let store = ReminderStore.shared
    let reminders = try await store.readAll()
    // Verify reminders are from Personal list
}
```

## Integration Tests

### iOS UI Tests

#### Test 6: Settings Button Visibility
**Steps**:
1. Launch app
2. Verify gear icon is visible in top-right corner
3. Tap gear icon
4. Verify Settings view appears

**Expected**: Settings view displays with "Reminder List" option

#### Test 7: List Selection
**Steps**:
1. Open Settings
2. Tap "Reminder List"
3. Verify picker shows all available lists
4. Select "Work" list
5. Tap "Done"
6. Verify main view refreshes

**Expected**: Calls displayed are from "Work" list

#### Test 8: Setting Persistence
**Steps**:
1. Select "Personal" list in Settings
2. Close app completely (swipe up from app switcher)
3. Relaunch app
4. Verify "Personal" list is still selected

**Expected**: Selection persists across app restarts

#### Test 9: Empty List Handling
**Steps**:
1. Select "Test Empty" list
2. Verify main view shows no calls
3. Pull to refresh
4. Verify no errors occur

**Expected**: Graceful handling of empty lists

#### Test 10: Reset to Default
**Steps**:
1. Select any non-default list
2. Open Settings
3. Tap "Reset to Default"
4. Verify list changes to "Volgende acties"
5. Verify main view updates

**Expected**: List resets and view refreshes automatically

### CarPlay Tests

#### Test 11: CarPlay Initial State
**Steps**:
1. Select "Work" list in iOS app
2. Connect to CarPlay
3. Open Next-calls in CarPlay
4. Verify calls are from "Work" list

**Expected**: CarPlay shows same list as iOS app

#### Test 12: CarPlay Live Update
**Steps**:
1. Connect to CarPlay with app running
2. Change list to "Personal" in iOS app
3. Check CarPlay interface
4. Verify CarPlay updates automatically

**Expected**: CarPlay reflects the change without restart

#### Test 13: CarPlay Refresh
**Steps**:
1. While in CarPlay, tap refresh button
2. Verify correct list is used for refresh

**Expected**: Refresh uses currently selected list

## Error Handling Tests

#### Test 14: Missing List Error
**Steps**:
1. Select "Work" list
2. Delete "Work" list in Reminders app
3. Reopen Next-calls app
4. Verify error message appears

**Expected**: Clear error: "Selected list not found. Please check settings."

#### Test 15: No Reminder Lists
**Steps**:
1. Delete all reminder lists (backup first!)
2. Open Settings
3. Verify appropriate message is shown

**Expected**: "No reminder lists found" message

#### Test 16: Permission Denied
**Steps**:
1. Revoke Reminders permission in iOS Settings
2. Open app
3. Verify error handling

**Expected**: Permission request or clear error message

## Performance Tests

#### Test 17: List Loading Speed
**Steps**:
1. Open Settings view
2. Measure time to load available lists
3. Verify loading indicator appears

**Expected**: Lists load within 1 second, spinner shown during load

#### Test 18: List Switch Speed
**Steps**:
1. Select a different list
2. Measure time for main view to refresh
3. Verify UI remains responsive

**Expected**: Refresh completes within 2 seconds, no UI blocking

#### Test 19: Background Refresh
**Steps**:
1. Switch to a list with many reminders (50+)
2. Pull to refresh
3. Verify UI remains responsive during refresh

**Expected**: No lag or stuttering during refresh

## Accessibility Tests

#### Test 20: VoiceOver Support
**Steps**:
1. Enable VoiceOver
2. Navigate to Settings
3. Verify all elements are accessible
4. Select a list using VoiceOver

**Expected**: All elements have proper labels and hints

#### Test 21: Dynamic Type
**Steps**:
1. Enable largest text size in iOS Settings
2. Open Settings view
3. Verify text is readable and not truncated

**Expected**: UI adapts to larger text sizes

#### Test 22: Voice Control
**Steps**:
1. Enable Voice Control
2. Say "Tap Settings"
3. Say "Tap Reminder List"
4. Select list using voice

**Expected**: All actions work with Voice Control

## Edge Cases

#### Test 23: Rapid List Changes
**Steps**:
1. Open Settings
2. Rapidly switch between multiple lists
3. Verify app doesn't crash or become unresponsive

**Expected**: Graceful handling of rapid changes

#### Test 24: Very Long List Name
**Steps**:
1. Create a list with a very long name (50+ characters)
2. Select it in app
3. Verify UI displays correctly

**Expected**: List name truncates appropriately

#### Test 25: Special Characters in List Name
**Steps**:
1. Create list with special characters: "Work 🔥 💼"
2. Select it in app
3. Verify it works correctly

**Expected**: Special characters handled properly

#### Test 26: Concurrent Changes
**Steps**:
1. Have app open on two devices (same iCloud account)
2. Change list on device 1
3. Verify device 2 behavior

**Expected**: Settings sync via iCloud (if enabled)

## Regression Tests

#### Test 27: Existing Functionality
**Steps**:
1. Verify pull-to-refresh still works
2. Verify call completion works
3. Verify navigation to call details works
4. Verify contact matching still works

**Expected**: All existing features continue to work

#### Test 28: Default Behavior
**Steps**:
1. Fresh install of app
2. Don't change any settings
3. Verify "Volgende acties" is used by default

**Expected**: Backward compatible with previous behavior

## Test Results Template

| Test # | Test Name | Status | Notes | Tester | Date |
|--------|-----------|--------|-------|--------|------|
| 1 | Default Value | ✅ Pass / ❌ Fail | | | |
| 2 | Persistence | ✅ Pass / ❌ Fail | | | |
| 3 | Reset to Default | ✅ Pass / ❌ Fail | | | |
| ... | ... | ... | | | |

## Critical Path Tests

Priority 1 (Must Pass):
- Test 6: Settings Button Visibility
- Test 7: List Selection
- Test 8: Setting Persistence
- Test 11: CarPlay Initial State
- Test 14: Missing List Error
- Test 28: Default Behavior

Priority 2 (Should Pass):
- Test 10: Reset to Default
- Test 12: CarPlay Live Update
- Test 15: No Reminder Lists
- Test 17: List Loading Speed
- Test 27: Existing Functionality

Priority 3 (Nice to Have):
- Test 20: VoiceOver Support
- Test 23: Rapid List Changes
- Test 26: Concurrent Changes

## Automated Testing Recommendations

### XCTest UI Tests
```swift
class SettingsUITests: XCTestCase {
    func testSettingsFlow() {
        let app = XCUIApplication()
        app.launch()
        
        // Tap settings button
        app.buttons["Settings"].tap()
        
        // Verify settings view appears
        XCTAssertTrue(app.staticTexts["Settings"].exists)
        
        // Tap Reminder List
        app.cells["Reminder List"].tap()
        
        // Select a list
        app.cells["Work"].tap()
        
        // Dismiss
        app.buttons["Done"].tap()
        
        // Verify main view
        XCTAssertTrue(app.navigationBars["Calls"].exists)
    }
}
```

### Performance Testing
```swift
func testListLoadingPerformance() {
    measure {
        // Open settings and load lists
        let store = ReminderStore.shared
        let lists = store.fetchAllLists()
    }
}
```

## Bug Reporting Template

When a test fails, use this template:

```
**Bug ID**: [Auto-generated or manual]
**Test Case**: [Test number and name]
**Severity**: Critical / High / Medium / Low
**Environment**: iOS [version], Device [model]

**Steps to Reproduce**:
1. 
2. 
3. 

**Expected Result**:

**Actual Result**:

**Screenshots/Logs**:

**Additional Notes**:
```

## Sign-off

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Developer | | | |
| QA Lead | | | |
| Product Owner | | | |
