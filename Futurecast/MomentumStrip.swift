import SwiftUI

struct MomentumData {
    var minutesListened: Int
    var dailyGoalMinutes: Int
    var streakDays: Int

    var progress: Double {
        min(Double(minutesListened) / Double(max(dailyGoalMinutes, 1)), 1.0)
    }
}

struct MomentumStrip: View {
    let data: MomentumData
    let onTap: () -> Void

    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: DesignTokens.Space.medium) {
                // Progress Ring
                ZStack {
                    Circle()
                        .stroke(
                            Color.white.opacity(0.15),
                            lineWidth: 3
                        )

                    Circle()
                        .trim(from: 0, to: data.progress)
                        .stroke(
                            LinearGradient(
                                colors: [DesignTokens.Colors.accentMint, DesignTokens.Colors.accentMintSoft],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))

                    Text("\(data.minutesListened)")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(DesignTokens.Colors.textPrimaryDark)
                }
                .frame(width: 48, height: 48)

                VStack(alignment: .leading, spacing: 2) {
                    Text("\(data.minutesListened) of \(data.dailyGoalMinutes) min")
                        .font(.system(
                            size: DesignTokens.Typography.metaSize,
                            weight: DesignTokens.Typography.metaWeight
                        ))
                        .foregroundStyle(DesignTokens.Colors.textPrimaryDark)

                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(DesignTokens.Colors.accentMint)

                        Text("\(data.streakDays) day streak")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(DesignTokens.Colors.textSecondaryDark)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(DesignTokens.Colors.textSecondaryDark)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(
                Group {
                    if reduceTransparency {
                        RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.chip, style: .continuous)
                            .fill(DesignTokens.Colors.graphiteElevated)
                    } else {
                        RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.chip, style: .continuous)
                            .fill(.ultraThinMaterial)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.chip, style: .continuous)
                        .strokeBorder(DesignTokens.Colors.hairlineOnDark, lineWidth: 1)
                )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        DesignTokens.Colors.graphiteBase
            .ignoresSafeArea()

        VStack(spacing: 24) {
            MomentumStrip(
                data: MomentumData(
                    minutesListened: 8,
                    dailyGoalMinutes: 15,
                    streakDays: 12
                ),
                onTap: {
                    print("Momentum strip tapped")
                }
            )

            MomentumStrip(
                data: MomentumData(
                    minutesListened: 15,
                    dailyGoalMinutes: 15,
                    streakDays: 45
                ),
                onTap: {
                    print("Momentum strip tapped")
                }
            )

            MomentumStrip(
                data: MomentumData(
                    minutesListened: 0,
                    dailyGoalMinutes: 10,
                    streakDays: 0
                ),
                onTap: {
                    print("Momentum strip tapped")
                }
            )
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
