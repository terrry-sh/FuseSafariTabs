#!/usr/bin/swift

import Foundation

func fuseSafariTabs() {
    let appleScript = """
    tell application "Safari"
        if (count of windows) = 0 then
            return "❌ No Safari windows are open."
        end if
        
        if (count of windows) = 1 then
            return "ℹ️ Only one Safari window is open. Nothing to merge."
        end if
        
        set windowCount to count of windows
        activate
        
        -- Use Safari's native "Merge All Windows" menu item
        tell application "System Events"
            tell process "Safari"
                click menu item "Merge All Windows" of menu "Window" of menu bar 1
            end tell
        end tell
        
        return "✅ Successfully merged " & (windowCount - 1) & " windows into one window"
    end tell
    """
    
    var error: NSDictionary?
    guard let scriptObject = NSAppleScript(source: appleScript) else {
        print("❌ Failed to create AppleScript")
        exit(1)
    }
    
    let output = scriptObject.executeAndReturnError(&error)
    
    if let error = error {
        if let errorMessage = error["NSAppleScriptErrorMessage"] as? String {
            print("❌ Error: \(errorMessage)")
        } else {
            print("❌ Error: \(error)")
        }
        exit(1)
    }
    
    if let result = output.stringValue {
        print(result)
        showNotification(message: result)
    }
}

func showNotification(message: String) {
    let task = Process()
    task.launchPath = "/usr/bin/osascript"
    task.arguments = ["-e", "display notification \"\(message)\" with title \"FuseSafariTabs\" sound name \"Glass\""]
    task.launch()
}

// Main execution
fuseSafariTabs()