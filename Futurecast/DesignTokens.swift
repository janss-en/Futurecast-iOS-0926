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

    enum Space {
        static let base: CGFloat = 12
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }

    enum CornerRadius {
        static let surface: CGFloat = 28
        static let chip: CGFloat = 18
        static let control: CGFloat = 16
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
