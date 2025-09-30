import SwiftUI

struct VerticalControlStack: View {
    let isPlaying: Bool
    let isLooping: Bool
    let onPlayTapped: () -> Void
    let onLoopTapped: () -> Void
    let onAudioTapped: () -> Void
    let onMoreTapped: () -> Void

    var body: some View {
        VStack(spacing: DesignTokens.Space.base) {
            // Play button
            Button(action: onPlayTapped) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: DesignTokens.IconSize.small))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
            }
            .frame(width: 46, height: 46)
            .background(.clear)
            .contentShape(RoundedRectangle(cornerRadius: 24, style: .circular))
            .glassEffect(.clear, in: RoundedRectangle(cornerRadius: 24, style: .circular))

            // Loop button
            Button(action: onLoopTapped) {
                Image(systemName: "repeat")
                    .font(.system(size: DesignTokens.IconSize.small))
                    .foregroundStyle(.white)
                    .opacity(isLooping ? 1.0 : 0.7)
                    .frame(width: 44, height: 44)
            }
            .frame(width: 46, height: 46)
            .background(.clear)
            .contentShape(RoundedRectangle(cornerRadius: 24, style: .circular))
            .glassEffect(.clear, in: RoundedRectangle(cornerRadius: 24, style: .circular))

            // Audio/headphones button
            Button(action: onAudioTapped) {
                Image(systemName: "airpods.max")
                    .font(.system(size: DesignTokens.IconSize.small))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
            }
            .frame(width: 46, height: 46)
            .background(.clear)
            .contentShape(RoundedRectangle(cornerRadius: 24, style: .circular))
            .glassEffect(.clear, in: RoundedRectangle(cornerRadius: 24, style: .circular))

            // More button
            Button(action: onMoreTapped) {
                Image(systemName: "ellipsis")
                    .font(.system(size: DesignTokens.IconSize.small))
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
            }
            .frame(width: 46, height: 46)
            .background(.clear)
            .contentShape(RoundedRectangle(cornerRadius: 24, style: .circular))
            .glassEffect(.clear, in: RoundedRectangle(cornerRadius: 24, style: .circular))
        }
        .padding(.vertical, DesignTokens.Space.base)
        .frame(width: 75)
    }
}

#Preview {
    ZStack {
        AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1656192390126-17080e87ec10")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            DesignTokens.Colors.graphiteBase
        }
        .ignoresSafeArea()

        VStack {
            Spacer()
            HStack {
                Spacer()
                VerticalControlStack(
                    isPlaying: false,
                    isLooping: false,
                    onPlayTapped: { print("Play") },
                    onLoopTapped: { print("Loop") },
                    onAudioTapped: { print("Audio") },
                    onMoreTapped: { print("More") }
                )
                .padding(.trailing, 12)
            }
        }
    }
    .preferredColorScheme(.dark)
}
