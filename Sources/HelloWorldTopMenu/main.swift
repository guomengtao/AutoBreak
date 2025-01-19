import Cocoa
import Foundation

@main
class TopMenuApp: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let timeString = dateFormatter.string(from: Date())
            button.title = "Hello World (\(timeString))"
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
