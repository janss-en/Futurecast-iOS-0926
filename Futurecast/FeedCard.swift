import SwiftUI

struct FeedCard: View {
    let visualization: Visualization
    let onPlayTapped: () -> Void
    let onLoopTapped: () -> Void
    let onShareTapped: () -> Void
    let onMoreTapped: () -> Void

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Image
                AsyncImage(url: URL(string: visualization.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ZStack {
                        DesignTokens.Colors.graphiteElevated
                        ProgressView()
                            .tint(DesignTokens.Colors.accentMint)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()

                // Bottom: Control Strip (replacing the glass affirmation text)
                VStack {
                    Spacer()

                    VStack(spacing: 0) {
                        // Affirmation text above control strip
                        Text(visualization.affirmation)
                            .font(.system(
                                size: DesignTokens.Typography.headlineSize,
                                weight: DesignTokens.Typography.headlineWeight
                            ))
                            .lineSpacing(DesignTokens.Typography.headlineSize * (DesignTokens.Typography.headlineLineHeight - 1))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, DesignTokens.Space.large)
                            .padding(.bottom, DesignTokens.Space.medium)
                            .shadow(
                                color: DesignTokens.Shadow.cardShadow().color,
                                radius: DesignTokens.Shadow.cardShadow().radius,
                                x: DesignTokens.Shadow.cardShadow().x,
                                y: DesignTokens.Shadow.cardShadow().y
                            )

                        // Control strip
                        LiquidGlassControlStripView(
                            configuration: ControlStripConfiguration(
                                isPlaying: visualization.isPlaying,
                                isLooping: visualization.isLooping,
                                isShareAvailable: true
                            )
                        )
                        .padding(.bottom, DesignTokens.Space.base)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(DesignTokens.Colors.graphiteBase)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.card, style: .continuous))
        }
    }
}

#Preview {
    ZStack {
        DesignTokens.Colors.graphiteBase
            .ignoresSafeArea()

        FeedCard(
            visualization: Visualization.mockData[0],
            onPlayTapped: {},
            onLoopTapped: {},
            onShareTapped: {},
            onMoreTapped: {}
        )
        .frame(height: 650)
        .padding()
    }
    .preferredColorScheme(.dark)
}
