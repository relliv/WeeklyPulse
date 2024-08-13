import Cocoa
import SwiftUI
import WeekNumberLibrary

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    var timer: Timer?

    private let calculator = WeekNumberCalculator()

    // Reference to the main window
    private var mainWindow: NSWindow?

    func applicationDidFinishLaunching(_: Notification) {
        setupStatusBar()
        setupTimer()

        // Create the main window but do not show it initially
        if mainWindow == nil {
            let contentView = ContentView()
            let hostingController = NSHostingController(rootView: contentView)
            mainWindow = NSWindow(
                contentViewController: hostingController
            )
            mainWindow?.title = "Weekly Pulse"
            mainWindow?.setFrame(NSRect(x: 0, y: 0, width: 550, height: 550), display: true)
            mainWindow?.isReleasedWhenClosed = false
            mainWindow?.center()
        }

        NSApp.setActivationPolicy(.accessory)
        NSApp.activate(ignoringOtherApps: true)
    }

    func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            // Create a SwiftUI view to represent the content
            let contentView = StatusBarView(weekNumber: getWeekNumberString(), progress: calculator.getYearProgress())
            let hostingView = NSHostingView(rootView: contentView)

            // Adjust the frame size of the hosting view
            hostingView.frame = NSRect(x: 0, y: 0, width: 100, height: 30)

            // Ensure that the hosting view is properly added and displayed
            button.addSubview(hostingView)
            button.frame = hostingView.frame // Set the button frame to match the hosting view

            // Set up action to open the main window when the button is clicked
            button.action = #selector(statusBarButtonClicked)
            button.target = self
        }
    }

    func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { _ in
            self.updateWeekNumber()
        }

        updateWeekNumber()
    }

    func updateWeekNumber() {
        if let button = statusItem.button, let hostingView = button.subviews.first as? NSHostingView<StatusBarView> {
            let progress = calculator.getYearProgress()
            hostingView.rootView = StatusBarView(weekNumber: getWeekNumberString(), progress: progress)
        }
    }

    func getWeekNumberString() -> String {
        let weekNumber = calculator.getWeekNumber(of: Date())
        return "Week \(weekNumber)"
    }

    @objc func statusBarButtonClicked() {
        // Show the main window when the button is clicked
        if let mainWindow = mainWindow {
            if mainWindow.isVisible {
                mainWindow.orderFront(self)
            } else {
                mainWindow.makeKeyAndOrderFront(self)
            }
        }
    }

    @objc func quitApplication() {
        NSApp.terminate(self)
    }
}

extension AppDelegate: NSWindowDelegate {
    func windowWillClose(_: Notification) {
        NSApp.hide(self)
    }
}

// SwiftUI view for status bar item
struct StatusBarView: View {
    let weekNumber: String
    let progress: Double

    var body: some View {
        VStack {
            Text(weekNumber)
                .font(.system(size: 12, weight: .medium))
            ProgressBar(value: progress)
                .frame(width: 37.5, height: 2.5)
                .padding(.top, 2)
        }
    }
}

// Custom ProgressBar
struct ProgressBar: View {
    var value: Double

    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: 37.5, height: 2.5)
                .foregroundColor(Color.gray.opacity(0.3))
                .cornerRadius(1.25)
            Rectangle()
                .frame(width: CGFloat(value) * 37.5, height: 2.5)
                .foregroundColor(.blue)
                .cornerRadius(1.25)
        }
    }
}
