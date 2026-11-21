import SwiftUI

struct SnowDriftCanvas: View {
    let intensity: Double
    let startedAt: Date

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 12.0)) { timeline in
            Canvas { context, size in
                let elapsed = max(0, timeline.date.timeIntervalSince(startedAt))
                let growth = min(elapsed / 180, 1)
                let height = size.height * CGFloat(0.045 + intensity * 0.025 + growth * 0.045)
                var drift = Path()
                drift.move(to: CGPoint(x: 0, y: size.height))

                let steps = max(1, Int(size.width / 12))
                for step in 0...steps {
                    let x = CGFloat(step) / CGFloat(steps) * size.width
                    let wave = sin(Double(step) * 0.27) * 0.006 + sin(Double(step) * 0.071 + 1.4) * 0.009
                    let y = size.height - height * CGFloat(1 + wave)
                    drift.addLine(to: CGPoint(x: x, y: y))
                }

                drift.addLine(to: CGPoint(x: size.width, y: size.height))
                drift.closeSubpath()

                context.fill(
                    drift,
                    with: .linearGradient(
                        Gradient(colors: [Color(red: 0.91, green: 0.96, blue: 1).opacity(0.82), .white]),
                        startPoint: CGPoint(x: 0, y: size.height - height),
                        endPoint: CGPoint(x: 0, y: size.height)
                    )
                )
            }
            .allowsHitTesting(false)
        }
        .accessibilityHidden(true)
    }
}
