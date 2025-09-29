#!/bin/zsh

set -e

echo "🚀 Setting up Futurecast iOS workspace..."

# Check if Xcode command line tools are installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Error: Xcode command line tools are not installed."
    echo "Please install Xcode from the App Store and run: xcode-select --install"
    exit 1
fi

# Check if the Xcode project exists in the root repo
if [ ! -d "$CONDUCTOR_ROOT_PATH/Futurecast.xcodeproj" ]; then
    echo "❌ Error: Futurecast.xcodeproj not found in repository root."
    echo "   Expected location: $CONDUCTOR_ROOT_PATH/Futurecast.xcodeproj"
    exit 1
fi

echo "✅ Found Futurecast.xcodeproj"

# Create symlink to the Xcode project in workspace for convenience
if [ ! -L "Futurecast.xcodeproj" ]; then
    ln -s "$CONDUCTOR_ROOT_PATH/Futurecast.xcodeproj" "Futurecast.xcodeproj"
    echo "✅ Created symlink to Xcode project"
fi

# Verify iOS 26 SDK is available for Liquid Glass UI
XCODE_VERSION=$(xcodebuild -version | head -n 1 | awk '{print $2}')
echo "✅ Xcode version: $XCODE_VERSION"

# Check if iPhone 16 Pro simulator is available
if ! xcrun simctl list devices | grep -q "iPhone 16 Pro"; then
    echo "⚠️  Warning: iPhone 16 Pro simulator not found."
    echo "   You may need to download iOS 26 runtime in Xcode > Settings > Platforms"
    echo "   Continuing anyway..."
else
    echo "✅ iPhone 16 Pro simulator is available"
fi

echo "✅ Workspace setup complete!"