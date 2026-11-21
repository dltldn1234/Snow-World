import SwiftUI

struct DesktopPreviewView: View {
    @ObservedObject var settings: SnowSettings
    @State private var startedAt = Date()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("WinterNight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()

                LinearGradient(
                    stops: [
                        .init(color: .black.opacity(0.35), location: 0),
                        .init(color: .clear, location: 0.34),
                        .init(color: .clear, location: 0.68),
                        .init(color: .black.opacity(0.24), location: 1),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )

                if settings.accumulatesSnow {
                    SnowDriftCanvas(intensity: settings.intensity, startedAt: startedAt)
                }

                SnowfallCanvas(isActive: settings.isSnowing, intensity: settings.intensity)

                VStack(alignment: .leading, spacing: 0) {
                    header
                    Spacer(minLength: 24)
                    footer
                }
                .padding(30)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 7) {
                Label("SNOW WORLD", systemImage: "sparkles")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .tracking(2.2)
                    .foregroundStyle(.white.opacity(0.92))

                Text("A little winter, right on your desktop.")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer()

            HStack(spacing: 8) {
                Circle()
                    .fill(settings.isSnowing ? Color.cyan.opacity(0.95) : Color.white.opacity(0.45))
                    .frame(width: 7, height: 7)
                Text(settings.isSnowing ? "SNOWFALL LIVE" : "PAUSED")
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .tracking(1.3)
                    .foregroundStyle(.white.opacity(0.85))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(.ultraThinMaterial, in: Capsule())
        }
    }

    private var footer: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 7) {
                Text("WINTER NIGHT")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(.white.opacity(0.72))
                Text("Snow is settling in.")
                    .font(.system(size: 20, weight: .medium, design: .serif))
                    .foregroundStyle(.white)
            }

            Spacer(minLength: 20)

            controls
        }
    }

    private var controls: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 10) {
                Image(systemName: "snowflake")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.cyan.opacity(0.9))
                Text("Snow controls")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                Spacer()
                Button {
                    settings.isSnowing.toggle()
                } label: {
                    Image(systemName: settings.isSnowing ? "pause.fill" : "play.fill")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 30, height: 30)
                        .background(.white.opacity(0.12), in: Circle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(settings.isSnowing ? "눈 내리기 일시정지" : "눈 내리기 시작")
            }

            VStack(spacing: 8) {
                HStack {
                    Text("Snowfall")
                    Spacer()
                    Text(intensityLabel)
                        .monospacedDigit()
                        .foregroundStyle(.white.opacity(0.65))
                }
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.white.opacity(0.88))

                Slider(value: $settings.intensity, in: 0.1...1)
                    .tint(Color(red: 0.59, green: 0.83, blue: 1))
            }

            Toggle(isOn: $settings.accumulatesSnow) {
                Label("Snow buildup", systemImage: "cloud.snow")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.white.opacity(0.88))
            }
            .toggleStyle(.switch)
            .controlSize(.mini)
        }
        .padding(17)
        .frame(width: 250)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .strokeBorder(.white.opacity(0.14), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.2), radius: 24, y: 12)
    }

    private var intensityLabel: String {
        switch settings.intensity {
        case ..<0.34: "Light"
        case ..<0.68: "Steady"
        default: "Heavy"
        }
    }
}
