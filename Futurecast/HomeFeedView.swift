import SwiftUI

struct HomeFeedView: View {
    @State private var visualizations = Visualization.mockData
    @State private var currentIndex: Int = 0
    @State private var momentumData = MomentumData(
        minutesListened: 8,
        dailyGoalMinutes: 15,
        streakDays: 12
    )

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Background
                DesignTokens.Colors.graphiteBase
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Momentum Strip at top
                    MomentumStrip(data: momentumData) {
                        // TODO: Open progress drawer
                        print("Open progress drawer")
                    }
                    .padding(.horizontal, DesignTokens.Space.medium)
                    .padding(.top, DesignTokens.Space.base)
                    .padding(.bottom, DesignTokens.Space.small)

                    // Scrollable card feed
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: DesignTokens.Space.large) {
                            ForEach(visualizations) { visualization in
                                FeedCard(
                                    visualization: visualization,
                                    onPlayTapped: {
                                        handlePlayTapped(for: visualization.id)
                                    },
                                    onLoopTapped: {
                                        handleLoopTapped(for: visualization.id)
                                    },
                                    onShareTapped: {
                                        handleShareTapped(for: visualization.id)
                                    },
                                    onMoreTapped: {
                                        handleMoreTapped(for: visualization.id)
                                    }
                                )
                                .frame(height: geometry.size.height * 0.75)
                                .scrollTransition { content, phase in
                                    content
                                        .scaleEffect(phase.isIdentity ? 1 : 0.95)
                                        .opacity(phase.isIdentity ? 1 : 0.5)
                                }
                            }
                        }
                        .padding(.horizontal, DesignTokens.Space.medium)
                        .padding(.bottom, 100) // Space for tab bar
                    }
                    .scrollTargetBehavior(.paging)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Actions

    private func handlePlayTapped(for id: UUID) {
        if let index = visualizations.firstIndex(where: { $0.id == id }) {
            visualizations[index].isPlaying.toggle()
            print("Play/Pause tapped for: \(visualizations[index].affirmation)")
        }
    }

    private func handleLoopTapped(for id: UUID) {
        if let index = visualizations.firstIndex(where: { $0.id == id }) {
            visualizations[index].isLooping.toggle()
            print("Loop toggled for: \(visualizations[index].affirmation)")
        }
    }

    private func handleShareTapped(for id: UUID) {
        if let visualization = visualizations.first(where: { $0.id == id }) {
            print("Share tapped for: \(visualization.affirmation)")
            // TODO: Open share sheet
        }
    }

    private func handleMoreTapped(for id: UUID) {
        if let visualization = visualizations.first(where: { $0.id == id }) {
            print("More tapped for: \(visualization.affirmation)")
            // TODO: Open more options menu
        }
    }
}

#Preview {
    HomeFeedView()
}
