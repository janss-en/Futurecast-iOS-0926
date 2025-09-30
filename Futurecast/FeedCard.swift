import SwiftUI

struct FeedCard: View {
    let visualization: Visualization
    let onPlayTapped: () -> Void
    let onLoopTapped: () -> Void
    let onAudioTapped: () -> Void
    let onMoreTapped: () -> Void

    @StateObject private var colorLoader = ImageColorLoader()

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

                // Bottom: Affirmation text with tinted glass background
                VStack {
                    Spacer()

                    Text(visualization.affirmation)
                        .font(.system(
                            size: DesignTokens.Typography.headlineSize,
                            weight: DesignTokens.Typography.headlineWeight
                        ))
                        .lineSpacing(DesignTokens.Typography.headlineSize * (DesignTokens.Typography.headlineLineHeight - 1))
                        .foregroundStyle(colorLoader.textColor)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, DesignTokens.Space.large)
                        .padding(.bottom, DesignTokens.Space.extraLarge)
                        .padding(.top, DesignTokens.Space.medium)
                        .background(.clear)
                        .glassEffect(
                            colorLoader.dominantColor != nil
                                ? .regular.tint((colorLoader.dominantColor ?? .clear).opacity(0.8))
                                : .regular,
                            in: RoundedRectangle(cornerRadius: 0, style: .circular)
                        )
                        .shadow(
                            color: DesignTokens.Shadow.cardShadow().color,
                            radius: DesignTokens.Shadow.cardShadow().radius,
                            x: DesignTokens.Shadow.cardShadow().x,
                            y: DesignTokens.Shadow.cardShadow().y
                        )
                }

                // Right rail: Vertical control stack
                VStack {
                    Spacer()
                    HStack(alignment: .bottom) {
                        Spacer()
                        VerticalControlStack(
                            isPlaying: visualization.isPlaying,
                            isLooping: visualization.isLooping,
                            onPlayTapped: onPlayTapped,
                            onLoopTapped: onLoopTapped,
                            onAudioTapped: onAudioTapped,
                            onMoreTapped: onMoreTapped
                        )
                        .padding(.trailing, DesignTokens.Space.base)
                        .padding(.bottom, 120) // Move up to avoid caption overlap
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(DesignTokens.Colors.graphiteBase)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.card, style: .continuous))
            .task {
                await colorLoader.loadColor(from: visualization.imageURL)
            }
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
            onAudioTapped: {},
            onMoreTapped: {}
        )
        .frame(height: 650)
        .padding()
    }
    .preferredColorScheme(.dark)
}
