# Futurecast iOS

A TikTok-style feed app for manifestation and goal visualization, helping users create, play, and loop affirmations paired with personalized visualizations.

## 🎯 Core Concept

**Futurecast** enables users to manifest their goals through a feed of visualizations paired with affirmations. Users can record their own voice affirmations, create AI-generated visualizations, organize content into boards, and listen on-the-go.

**Primary Flow**: Create → Play/Loop → Share → Organize → Progress → Repeat

## 📱 Key Features

- **TikTok-style feed** with single-card focus and smooth transitions
- **Audio affirmations** with user recording + optional TTS fallback
- **AI-generated visualizations** with Personal Visual Pack (PVP) support
- **Board organization** with starred items and Loop Board functionality
- **Progress tracking** with daily goals and streak maintenance
- **Share functionality** with branded vertical videos
- **Dark/light themes** with mint accent colors

## 🎨 Design System

The complete design specification is available in [`docs/design-system.md`](docs/design-system.md), including:

- Brand foundations and color tokens
- Component specifications
- User flows and creation patterns
- Accessibility guidelines
- Implementation notes

## 🚀 Development Status

This project is in early development. See the [build order suggestions](docs/design-system.md#18-v1-build-order-suggested) in the design system for development priorities.

## 📋 Project Structure

```
Futurecast-iOS-0926/
├── Futurecast/                 # Main app source
│   ├── FuturecastApp.swift     # App entry point
│   ├── ContentView.swift       # Main content view
│   ├── Item.swift              # Data models
│   └── Assets.xcassets/        # App assets
├── Futurecast.xcodeproj        # Xcode project
├── docs/
│   └── design-system.md        # Complete design specification
└── README.md                   # This file
```

## 🛠 Getting Started

1. Open `Futurecast.xcodeproj` in Xcode
2. Review the [design system documentation](docs/design-system.md)
3. Build and run the project

---

*Built with SwiftUI for iOS*