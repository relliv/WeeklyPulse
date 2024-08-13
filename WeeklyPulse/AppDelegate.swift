import Cocoa
import SwiftUI
import WeekNumberLibrary

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var timer: Timer?
    private let calculator = WeekNumberCalculator()

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusBar()
        setupTimer()
        
        NSApplication.shared.windows.first?.delegate = self
    }

    func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.title = getWeekNumberString()
            button.action = #selector(statusBarButtonClicked)
            
            let menu = NSMenu()
            let quitItem = NSMenuItem(title: "Quit", action: #selector(quitApplication), keyEquivalent: "q")
            menu.addItem(quitItem)
            statusItem.menu = menu
        }
    }

    func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { _ in
            self.updateWeekNumber()
        }
        
        updateWeekNumber()
    }
    
    func updateWeekNumber() {
        if let button = statusItem.button {
            button.title = getWeekNumberString()
        }
    }
    
    func getWeekNumberString() -> String {
        let weekNumber = calculator.getWeekNumber(of: Date())
        return "Week \(weekNumber)"
    }
    
    @objc func statusBarButtonClicked() {
    }
    
    @objc func quitApplication() {
        NSApp.terminate(self)
    }
}

extension AppDelegate: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        NSApp.terminate(self)
    }
}
