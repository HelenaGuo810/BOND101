import SwiftUI

// MARK: - Palette (from the Figma file's own color values)

enum Palette {
    // Warm dark theme
    static let bg = Color(hex: 0x171213)
    static let bgDeep = Color(hex: 0x120D0E)
    static let surface = Color(hex: 0x201A1B)
    static let surface2 = Color(hex: 0x241E1F)
    static let surface3 = Color(hex: 0x2F2829)
    static let cardTop = Color(hex: 0x3E3838)
    static let chip = Color(hex: 0x3A3334)
    static let border = Color(hex: 0x514345)
    static let textPrimary = Color(hex: 0xEBE0E0)
    static let textSecondary = Color(hex: 0xD6C2C4)
    static let blush = Color(hex: 0xFFB7C5)
    static let blushLight = Color(hex: 0xFFDEE3)
    static let blushDark = Color(hex: 0x50212D)
    static let amber = Color(hex: 0xF0BD8B)
    static let amberDeep = Color(hex: 0x65411A)
    static let green = Color(hex: 0xA7D6AD)
    static let peach = Color(hex: 0xFFDCBD)

    // Blue (jealousy) theme
    static let blueBg = Color(hex: 0x0B111A)
    static let blueSurface = Color(hex: 0x121C2B)
    static let blueBorder = Color(hex: 0x1E2E42)
    static let blueText = Color(hex: 0xD2E3FC)
    static let blueAccent = Color(hex: 0x8AB4F8)
}

extension Color {
    init(hex: UInt32, alpha: Double = 1) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

// MARK: - Fonts

extension Font {
    static func jakarta(_ size: CGFloat, weight: Font.Weight = .regular, relativeTo style: Font.TextStyle = .body) -> Font {
        let name: String
        switch weight {
        case .bold, .heavy, .black: name = "PlusJakartaSans-Bold"
        case .semibold: name = "PlusJakartaSans-SemiBold"
        case .medium: name = "PlusJakartaSans-Medium"
        default: name = "PlusJakartaSans-Regular"
        }
        return .custom(name, size: size, relativeTo: style)
    }

    static func bodoni(_ size: CGFloat, italic: Bool = false, relativeTo style: Font.TextStyle = .title) -> Font {
        .custom(italic ? "BodoniModa-Italic" : "BodoniModa-Regular", size: size, relativeTo: style)
    }
}

// MARK: - Shared text styles

/// Small uppercase tracked caption used throughout the design.
struct KickerText: View {
    let text: String
    var color: Color = Palette.textSecondary
    var size: CGFloat = 12

    var body: some View {
        Text(text)
            .font(.jakarta(size, weight: .bold, relativeTo: .caption))
            .tracking(1.2)
            .textCase(.uppercase)
            .foregroundStyle(color)
    }
}
