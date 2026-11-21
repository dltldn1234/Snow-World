import SwiftUI

struct SnowfallCanvas: View {
    let isActive: Bool
    let intensity: Double

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 60.0, paused: !isActive)) { timeline in
            Canvas { context, size in
                let time = timeline.date.timeIntervalSinceReferenceDate
                let width = Double(size.width)
                let height = Double(size.height)
                let count = Int(90 + intensity * 230)

                for index in 0..<count {
                    let seed = Double(index)
                    let seedX = fractional(seed * 0.754877666 + 0.173)
                    let seedY = fractional(seed * 0.569840296 + 0.413)
                    let speed = 0.035 + fractional(seed * 0.438579 + 0.23) * 0.105
                    let phase = time * speed + seedY
                    let y = fractional(phase) * height
                    let sway = sin(time * (0.45 + seedX) + seed * 0.71) * width * 0.008
                    let drift = (phase - seedY) * width * 0.012
                    var x = (seedX * width + sway + drift)
                        .truncatingRemainder(dividingBy: max(width, 1))
                    if x < 0 { x += width }
                    let radius = 0.7 + fractional(seed * 0.191 + 0.31) * (1.2 + intensity * 1.7)
                    let rect = CGRect(
                        x: CGFloat(x),
                        y: CGFloat(y),
                        width: CGFloat(radius * 2),
                        height: CGFloat(radius * 2)
                    )

                    context.fill(
                        Path(ellipseIn: rect),
                        with: .color(.white.opacity(0.2 + fractional(seed * 0.117) * 0.65))
                    )
                }
            }
            .allowsHitTesting(false)
        }
        .accessibilityHidden(true)
    }

    private func fractional(_ value: Double) -> Double {
        value - floor(value)
    }
}
