import Cocoa

@main
class TopMenuApp: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.title = "Hello World"
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
