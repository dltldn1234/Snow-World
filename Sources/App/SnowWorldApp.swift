import SwiftUI
import AppKit

@main
struct SnowWorldApp: App {
    @StateObject private var settings = SnowSettings()

    var body: some Scene {
        WindowGroup("Snow World") {
            DesktopPreviewView(settings: settings)
                .frame(minWidth: 900, minHeight: 560)
        }
        .defaultSize(width: 1280, height: 720)

        MenuBarExtra("Snow World", systemImage: "snowflake") {
            Button("Snow World 창 열기") {
                NSApp.activate(ignoringOtherApps: true)
                for window in NSApp.windows where window.canBecomeKey {
                    window.makeKeyAndOrderFront(nil)
                }
            }

            Divider()

            Toggle("눈 내리기", isOn: $settings.isSnowing)
            Toggle("바닥에 눈 쌓기", isOn: $settings.accumulatesSnow)

            Divider()

            Button("Snow World 종료") {
                NSApp.terminate(nil)
            }
            .keyboardShortcut("q")
        }
        .menuBarExtraStyle(.menu)
    }
}
