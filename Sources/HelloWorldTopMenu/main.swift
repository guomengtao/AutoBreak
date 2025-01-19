import Cocoa
import Foundation

@main
class TopMenuApp: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var countdownTimer: Timer?
    var remainingSeconds = 60
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // Start the countdown
        startCountdown()
    }
    
    func startCountdown() {
        // Reset remaining seconds
        remainingSeconds = 60
        
        // Update status item title immediately
        updateStatusItemTitle()
        
        // Create a timer that fires every second
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            // Decrement remaining seconds
            self.remainingSeconds -= 1
            
            // Update status item title
            self.updateStatusItemTitle()
            
            // Check if time is up
            if self.remainingSeconds <= 0 {
                // Lock the screen
                self.lockScreen()
                
                // Invalidate the timer
                timer.invalidate()
                
                // Restart the countdown
                self.startCountdown()
            }
        }
    }
    
    func updateStatusItemTitle() {
        if let button = statusItem?.button {
            button.title = "Lock in: \(remainingSeconds)s"
        }
    }
    
    func lockScreen() {
        // Use macOS command to lock screen
        let task = Process()
        task.launchPath = "/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession"
        task.arguments = ["-suspend"]
        
        do {
            try task.run()
        } catch {
            print("Failed to lock screen: \(error)")
        }
    }
    
    static func main() {
        let app = NSApplication.shared
        let delegate = TopMenuApp()
        app.delegate = delegate
        
        // Prevent app from appearing in dock
        NSApp.setActivationPolicy(.accessory)
        
        // Run the application
        app.run()
    }
}
