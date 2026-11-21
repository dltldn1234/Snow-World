import Combine
import Foundation

@MainActor
final class SnowSettings: ObservableObject {
    private let defaults = UserDefaults.standard

    @Published var isSnowing: Bool {
        didSet { defaults.set(isSnowing, forKey: Key.isSnowing) }
    }

    @Published var accumulatesSnow: Bool {
        didSet { defaults.set(accumulatesSnow, forKey: Key.accumulatesSnow) }
    }

    @Published var intensity: Double {
        didSet { defaults.set(intensity, forKey: Key.intensity) }
    }

    init() {
        isSnowing = defaults.object(forKey: Key.isSnowing) as? Bool ?? true
        accumulatesSnow = defaults.object(forKey: Key.accumulatesSnow) as? Bool ?? true
        intensity = defaults.object(forKey: Key.intensity) as? Double ?? 0.72
    }

    private enum Key {
        static let isSnowing = "snow.isSnowing"
        static let accumulatesSnow = "snow.accumulatesSnow"
        static let intensity = "snow.intensity"
    }
}
