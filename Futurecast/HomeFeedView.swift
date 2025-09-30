import SwiftUI

// MARK: - Scroll Offset Tracking

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Home Feed View

struct HomeFeedView: View {
    @State private var visualizations = Visualization.mockData
    @State private var currentIndex: Int = 0
    @State private var momentumData = MomentumData(
        minutesListened: 8,
        dailyGoalMinutes: 15,
        streakDays: 12
    )
    @State private var scrollOffset: CGFloat = 0
    @State private var isStripDismissed: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Background
                DesignTokens.Colors.graphiteBase
                    .ignoresSafeArea()

                // Scrollable content with Momentum Strip inside
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        // Momentum Strip at the top of scroll content
                        MomentumStrip(data: momentumData) {
                            // TODO: Open progress drawer
                            print("Open progress drawer")
                        }
                        .padding(.horizontal, DesignTokens.Space.medium)
                        .padding(.top, DesignTokens.Space.base)
                        .padding(.bottom, DesignTokens.Space.large)
                        .opacity(momentumStripOpacity)
                        .offset(y: momentumStripOffset)
                        .animation(.easeOut(duration: 0.25), value: scrollOffset)

                        // Card feed
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
                                    onAudioTapped: {
                                        handleAudioTapped(for: visualization.id)
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
                        .background(
                            GeometryReader { scrollGeometry in
                                Color.clear
                                    .preference(
                                        key: ScrollOffsetPreferenceKey.self,
                                        value: scrollGeometry.frame(in: .named("scroll")).minY
                                    )
                            }
                        )

                        Spacer(minLength: 100) // Space for tab bar
                    }
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    scrollOffset = value
                    updateStripVisibility()
                }
                .scrollTargetBehavior(.paging)
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Computed Properties

    private var momentumStripOpacity: Double {
        // Once dismissed, only show when pulling to reveal
        if isStripDismissed {
            // Pull-to-reveal: only show when user pulls down beyond threshold
            if scrollOffset > 100 {
                return 1.0
            } else if scrollOffset > 50 {
                // Gradual fade in as user pulls down
                return (scrollOffset - 50) / 50
            } else {
                return 0
            }
        } else {
            // Initial state: visible, fade out as scrolling down
            if scrollOffset > 0 {
                return 1.0
            } else if scrollOffset > -50 {
                // Fading out while scrolling down
                return max(0, 1.0 + (scrollOffset / 50))
            } else {
                return 0
            }
        }
    }

    private var momentumStripOffset: CGFloat {
        // Slight upward offset when fading out for smoother transition
        if scrollOffset < 0 && !isStripDismissed {
            return min(0, scrollOffset * 0.3)
        }
        return 0
    }

    // MARK: - Helper Methods

    private func updateStripVisibility() {
        // Mark strip as dismissed once user scrolls down significantly
        if !isStripDismissed && scrollOffset < -100 {
            isStripDismissed = true
        }

        // Reset dismissed state when user pulls to reveal
        if isStripDismissed && scrollOffset > 120 {
            isStripDismissed = false
        }
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
