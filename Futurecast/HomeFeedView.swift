import SwiftUI

struct HomeFeedView: View {
    @State private var visualizations = Visualization.mockData
    @State private var currentIndex: Int = 0
    @State private var momentumData = MomentumData(
        minutesListened: 8,
        dailyGoalMinutes: 15,
        streakDays: 12
    )
    @State private var isStripDismissed: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Background
                DesignTokens.Colors.graphiteBase
                    .ignoresSafeArea()

                // Scrollable card feed
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(visualizations) { visualization in
                            FeedCard(
                                visualization: visualization,
                                onPlayTapped: {
                                    handlePlayTapped(for: visualization.id)
                                },
                                onLoopTapped: {
                                    handleLoopTapped(for: visualization.id)
                                },
                                onAudioTapped: {
                                    handleAudioTapped(for: visualization.id)
                                },
                                onMoreTapped: {
                                    handleMoreTapped(for: visualization.id)
                                }
                            )
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .scrollTransition { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1 : 0.95)
                                    .opacity(phase.isIdentity ? 1 : 0.5)
                            }
                            .containerRelativeFrame(.vertical)
                            .onTapGesture {
                                // Dismiss momentum strip on card tap
                                withAnimation(.easeOut(duration: 0.3)) {
                                    isStripDismissed = true
                                }
                            }
                        }
                    }
                }
                .scrollTargetBehavior(.paging)

                // Floating Momentum Strip overlay
                if !isStripDismissed {
                    VStack(spacing: 0) {
                        MomentumStrip(data: momentumData) {
                            // TODO: Open progress drawer
                            print("Open progress drawer")
                        }
                        .padding(.horizontal, DesignTokens.Space.medium)
                        .padding(.top, DesignTokens.Space.base)
                        .transition(.move(edge: .top).combined(with: .opacity))

                        // Tappable transparent area below strip
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                // Dismiss on tap in card area
                                withAnimation(.easeOut(duration: 0.3)) {
                                    isStripDismissed = true
                                }
                            }
                    }
                    .allowsHitTesting(true)
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

    private func handleAudioTapped(for id: UUID) {
        if let visualization = visualizations.first(where: { $0.id == id }) {
            print("Audio tapped for: \(visualization.affirmation)")
            // TODO: Toggle ambient audio or show audio settings
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
