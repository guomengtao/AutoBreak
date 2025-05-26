import Cocoa
import Foundation

@main
class TopMenuApp: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var countdownTimer: Timer?
    var remainingSeconds = 60
    var selectedDuration = 60
    var isOneTimeMode = false
    var isCountdownActive = false
    
    // 版本信息
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    let appName = "HelloWorldTopMenu"
    let githubRepo = "https://github.com/guomengtao/HelloWorldTopMenu"
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        // Setup initial menu
        setupMenu()
        
        // Start the countdown
        startCountdown()
    }
    
    func setupMenu() {
        let menu = NSMenu()
        
        // 添加项目信息
        let projectInfoItem = NSMenuItem(title: "\(appName) v\(appVersion)", action: nil, keyEquivalent: "")
        projectInfoItem.isEnabled = false
        menu.addItem(projectInfoItem)
        
        // 添加 GitHub 链接
        let githubItem = NSMenuItem(title: "GitHub Repository", action: #selector(openGitHub), keyEquivalent: "")
        githubItem.target = self
        menu.addItem(githubItem)
        
        menu.addItem(NSMenuItem.separator())
        
        // Countdown time submenu
        let countdownSubmenu = NSMenu()
        let countdownMenuItem = NSMenuItem(title: "Countdown Time", action: nil, keyEquivalent: "")
        countdownMenuItem.submenu = countdownSubmenu
        
        // Countdown time options
        let durations = [
            ("10 seconds", 10),
            ("60 seconds", 60),
            ("5 minutes", 300),
            ("15 minutes", 900),
            ("30 minutes", 1800),
            ("60 minutes", 3600)
        ]
        
        for (title, duration) in durations {
            let item = NSMenuItem(title: title, action: #selector(setCountdownTime(_:)), keyEquivalent: "")
            item.target = self
            item.representedObject = duration
            countdownSubmenu.addItem(item)
        }
        
        // One-time mode toggle
        let oneTimeModeItem = NSMenuItem(title: "One-time Mode", action: #selector(toggleOneTimeMode(_:)), keyEquivalent: "")
        oneTimeModeItem.target = self
        oneTimeModeItem.state = isOneTimeMode ? .on : .off
        menu.addItem(oneTimeModeItem)
        
        // Add submenu to main menu
        menu.addItem(countdownMenuItem)
        
        // Set the menu to the status item
        statusItem?.menu = menu
    }
    
    @objc func openGitHub() {
        if let url = URL(string: githubRepo) {
            NSWorkspace.shared.open(url)
        }
    }
    
    @objc func setCountdownTime(_ sender: NSMenuItem) {
        guard let duration = sender.representedObject as? Int else { return }
        
        // Stop current countdown
        countdownTimer?.invalidate()
        
        // Set new duration
        selectedDuration = duration
        remainingSeconds = duration
        isCountdownActive = true
        
        // Forcibly close the menu
        statusItem?.menu = nil
        
        // Restart countdown
        startCountdown()
    }
    
    @objc func toggleOneTimeMode(_ sender: NSMenuItem) {
        guard !isCountdownActive else { return }
        isOneTimeMode.toggle()
        sender.state = isOneTimeMode ? .on : .off
    }
    
    func startCountdown() {
        // Reset remaining seconds
        remainingSeconds = selectedDuration
        isCountdownActive = true
        
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
                
                // Restart the countdown based on mode
                if self.isOneTimeMode {
                    // Reset to default 60 seconds after one-time mode
                    self.selectedDuration = 60
                    self.isOneTimeMode = false
                }
                
                // Reset countdown active state
                self.isCountdownActive = false
                
                // Recreate menu
                self.setupMenu()
                
                // Restart the countdown
                self.startCountdown()
            }
        }
    }
    
    func updateStatusItemTitle() {
        if let button = statusItem?.button {
            let minutes = remainingSeconds / 60
            let seconds = remainingSeconds % 60
            // 使用锁图标替代 "Lock in:" 文本
            button.title = "🔒 \(String(format: "%02d:%02d", minutes, seconds))"
        }
    }
    
    func lockScreen() {
        // Use shell command to lock screen
        let task = Process()
        task.launchPath = "/bin/bash"
        
        // Special lock durations for specific countdown times
        var lockCommand = "osascript -e 'tell application \"System Events\" to sleep'"
        
        // Add MacOSLock specific durations
        if selectedDuration == 1800 { // 30 minutes countdown
            lockCommand = "osascript -e 'tell application \"MacOSLock\" to open location \"macoslock://lock?duration=300\"'"
        } else if selectedDuration == 3600 { // 60 minutes countdown
            lockCommand = "osascript -e 'tell application \"MacOSLock\" to open location \"macoslock://lock?duration=600\"'"
        } else if selectedDuration == 10 { // 10 seconds countdown
            lockCommand = "osascript -e 'tell application \"MacOSLock\" to open location \"macoslock://lock?duration=20\"'"
        }
        
        task.arguments = ["-c", lockCommand]
        
        do {
            try task.run()
            task.waitUntilExit()
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
