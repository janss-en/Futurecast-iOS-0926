import SwiftUI

// Centralized design tokens derived from the Futurecast design system spec.
enum DesignTokens {
    enum Colors {
        static let graphiteBase = Color(hex: 0x0E0F10)
        static let graphiteElevated = Color(hex: 0x131416)
        static let graphiteOverlay = Color(hex: 0x1A1B1C)
        static let textPrimaryDark = Color(hex: 0xEDEFF1)
        static let textSecondaryDark = Color.white.opacity(0.68)
        static let accentMint = Color(hex: 0x2ED3C6)
        static let accentMintSoft = Color(hex: 0x6FE3D8)
        static let hairlineOnDark = Color.white.opacity(0.12)
    }

    enum Typography {
        static let headlineSize: CGFloat = 24
        static let headlineWeight: Font.Weight = .semibold
        static let headlineLineHeight: CGFloat = 1.2

        static let bodySize: CGFloat = 16
        static let bodyWeight: Font.Weight = .regular
        static let bodyLineHeight: CGFloat = 1.45

        static let metaSize: CGFloat = 14
        static let metaWeight: Font.Weight = .medium
    }

    enum Space {
        static let base: CGFloat = 12
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }

    enum CornerRadius {
        static let surface: CGFloat = 28
        static let card: CGFloat = 32
        static let fab: CGFloat = 20
        static let chip: CGFloat = 18
        static let control: CGFloat = 16
        static let button: CGFloat = 14
    }

    enum IconSize {
        static let small: CGFloat = 18
        static let medium: CGFloat = 24
        static let large: CGFloat = 32
    }

    enum Shadow {
        static func cardShadow() -> (color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
            (Color.black.opacity(0.35), 24, 2, 2)
        }
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
