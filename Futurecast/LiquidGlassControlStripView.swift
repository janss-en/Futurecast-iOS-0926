import SwiftUI

struct ControlStripConfiguration: Equatable {
    var isPlaying: Bool
    var isLooping: Bool
    var isShareAvailable: Bool
    var reduceTransparencyOverride: Bool? = nil
}

struct LiquidGlassControlStripView: View {
    var configuration: ControlStripConfiguration

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    private var useMatteFallback: Bool {
        configuration.reduceTransparencyOverride ?? reduceTransparency
    }

    private var backgroundShape: some Shape {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
    }

    private var glassBackground: some View {
        backgroundShape
            .fill(.clear)
            .background(
                backgroundShape
                    .fill(useMatteFallback ? DesignTokens.Colors.graphiteElevated : .ultraThinMaterial)
            )
            .overlay(
                backgroundShape
                    .strokeBorder(borderGradient, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(useMatteFallback ? 0.35 : 0.45), radius: 28, y: 24)
            .overlay(
                backgroundShape
                    .stroke(Color.white.opacity(colorScheme == .dark ? 0.06 : 0.12), lineWidth: 0.5)
                    .blendMode(.plusLighter)
            )
    }

    private var borderGradient: LinearGradient {
        if useMatteFallback {
            return LinearGradient(colors: [Color.white.opacity(0.14), Color.white.opacity(0.04)], startPoint: .topLeading, endPoint: .bottomTrailing)
        } else {
            return LinearGradient(colors: [Color.white.opacity(0.32), Color.white.opacity(0.08)], startPoint: .top, endPoint: .bottom)
        }
    }

    var body: some View {
        HStack(spacing: 24) {
            ControlStripButton(icon: configuration.isPlaying ? "pause.fill" : "play.fill",
                               isPrimary: true,
                               isActive: true,
                               label: configuration.isPlaying ? "Pause" : "Play")
            ControlStripButton(icon: "repeat",
                               isPrimary: false,
                               isActive: configuration.isLooping,
                               label: configuration.isLooping ? "Looping" : "Loop")
            ControlStripButton(icon: "square.and.arrow.up",
                               isPrimary: false,
                               isDisabled: !configuration.isShareAvailable,
                               label: "Share")
            ControlStripButton(icon: "ellipsis",
                               isPrimary: false,
                               label: "More")
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .background(glassBackground)
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.white.opacity(useMatteFallback ? 0.12 : 0.08), lineWidth: 1)
                .blendMode(.plusLighter)
        )
        .padding(.horizontal, 12)
    }
}

private struct ControlStripButton: View {
    var icon: String
    var isPrimary: Bool
    var isActive: Bool = false
    var isDisabled: Bool = false
    var label: String

    private var baseSize: CGFloat { isPrimary ? 56 : 44 }

    var body: some View {
        Button(action: {}) {
            Image(systemName: icon)
                .font(.system(size: isPrimary ? 22 : 18, weight: isPrimary ? .medium : .semibold))
                .frame(width: baseSize, height: baseSize)
                .background(background)
                .overlay(activeOverlay)
                .foregroundStyle(foreground)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .accessibilityLabel(label)
    }

    private var foreground: LinearGradient {
        if isDisabled {
            return LinearGradient(colors: [Color.white.opacity(0.4)], startPoint: .top, endPoint: .bottom)
        }
        if isPrimary {
            return LinearGradient(colors: [Color.white, Color.white.opacity(0.9)], startPoint: .top, endPoint: .bottom)
        }
        if isActive {
            return LinearGradient(colors: [DesignTokens.Colors.accentMint, DesignTokens.Colors.accentMintSoft], startPoint: .leading, endPoint: .trailing)
        }
        return LinearGradient(colors: [Color.white, Color.white.opacity(0.92)], startPoint: .top, endPoint: .bottom)
    }

    private var background: some View {
        Group {
            if isPrimary {
                Circle()
                    .fill(LinearGradient(colors: [DesignTokens.Colors.accentMint, DesignTokens.Colors.accentMintSoft], startPoint: .topLeading, endPoint: .bottomTrailing))
            } else if isActive {
                Circle()
                    .fill(Color.white.opacity(0.12))
            } else {
                Circle()
                    .fill(Color.white.opacity(0.04))
            }
        }
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(isPrimary ? 0.2 : 0.12), lineWidth: 1)
            )
    }

    private var activeOverlay: some View {
        Group {
            if isPrimary {
                Circle()
                    .stroke(DesignTokens.Colors.accentMintSoft.opacity(0.4), lineWidth: 3)
                    .blur(radius: 6)
            } else if isActive {
                Circle()
                    .stroke(DesignTokens.Colors.accentMint.opacity(0.6), lineWidth: 2)
                    .blur(radius: 4)
            }
        }
    }
}

struct ControlStripPreviewWrapper: View {
    @State private var isPlaying = false
    @State private var isLooping = false
    @State private var reduceTransparency = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black, Color(red: 0.07, green: 0.1, blue: 0.11)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 32) {
                toggleRow
                LiquidGlassControlStripView(
                    configuration: ControlStripConfiguration(
                        isPlaying: isPlaying,
                        isLooping: isLooping,
                        isShareAvailable: true,
                        reduceTransparencyOverride: reduceTransparency
                    )
                )
                Spacer()
            }
            .padding(.top, 60)
            .padding(.horizontal, 24)
        }
        .preferredColorScheme(.dark)
    }

    private var toggleRow: some View {
        VStack(alignment: .leading, spacing: 12) {
            Toggle("Playing", isOn: $isPlaying)
            Toggle("Loop On", isOn: $isLooping)
            Toggle("Reduce Transparency", isOn: $reduceTransparency)
        }
        .tint(DesignTokens.Colors.accentMint)
        .foregroundStyle(Color.white)
    }
}

#Preview("Interactive") {
    ControlStripPreviewWrapper()
}

#Preview("Paused") {
    LiquidGlassControlStripView(
        configuration: ControlStripConfiguration(
            isPlaying: false,
            isLooping: false,
            isShareAvailable: true
        )
    )
    .padding()
    .background(DesignTokens.Colors.graphiteBase)
    .preferredColorScheme(.dark)
}

#Preview("Reduce Transparency") {
    LiquidGlassControlStripView(
        configuration: ControlStripConfiguration(
            isPlaying: true,
            isLooping: true,
            isShareAvailable: false,
            reduceTransparencyOverride: true
        )
    )
    .padding()
    .background(DesignTokens.Colors.graphiteBase)
    .preferredColorScheme(.dark)
}

