import SwiftUI

// MARK: - Visualization Model

struct Visualization: Identifiable {
    let id: UUID
    let imageURL: String
    let affirmation: String
    let board: String?
    let durationSeconds: Int
    var isPlaying: Bool = false
    var isLooping: Bool = false

    init(
        id: UUID = UUID(),
        imageURL: String,
        affirmation: String,
        board: String? = nil,
        durationSeconds: Int = 30,
        isPlaying: Bool = false,
        isLooping: Bool = false
    ) {
        self.id = id
        self.imageURL = imageURL
        self.affirmation = affirmation
        self.board = board
        self.durationSeconds = durationSeconds
        self.isPlaying = isPlaying
        self.isLooping = isLooping
    }
}

// MARK: - Mock Data

extension Visualization {
    static let mockData: [Visualization] = [
        Visualization(
            imageURL: "https://images.unsplash.com/photo-1656192390126-17080e87ec10?ixid=M3w4OTk0OHwwfDF8c2VhcmNofDExfHxnZXJtYW4lMjBzaGVwaGVyZHxlbnwwfHx8fDE3NTkwMzIwOTJ8MA&ixlib=rb-4.1.0",
            affirmation: "I move my body and feel stronger every day.",
            board: "Fitness",
            durationSeconds: 45
        ),
        Visualization(
            imageURL: "https://images.unsplash.com/photo-1503256207526-0d5d80fa2f47?ixid=M3w4OTk0OHwwfDF8c2VhcmNofDJ8fGRvZ3xlbnwwfHx8fDE3NTkwMzE4NTB8MA&ixlib=rb-4.1.0",
            affirmation: "I am happy and confident.",
            board: "Wellness",
            durationSeconds: 30
        ),
        Visualization(
            imageURL: "https://images.unsplash.com/photo-1633564522273-2b2a3f21d860?ixid=M3w4OTk0OHwwfDF8c2VhcmNofDIxfHxnZXJtYW4lMjBzaGVwaGVyZHxlbnwwfHx8fDE3NTkwMzIwOTJ8MA&ixlib=rb-4.1.0",
            affirmation: "I hear and obey God's word.",
            board: "Spiritual",
            durationSeconds: 60
        ),
        Visualization(
            imageURL: "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800",
            affirmation: "I welcome abundance and prosperity into my life.",
            board: "Abundance",
            durationSeconds: 40
        ),
        Visualization(
            imageURL: "https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800",
            affirmation: "My mind is clear and focused on my goals.",
            board: "Focus",
            durationSeconds: 35
        )
    ]
}
