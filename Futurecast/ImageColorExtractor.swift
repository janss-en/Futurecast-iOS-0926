import SwiftUI
import UIKit
import Combine

// MARK: - Color Extraction

extension UIImage {
    /// Extracts the dominant color from the image using averaging
    func dominantColor() -> UIColor? {
        guard let cgImage = self.cgImage else { return nil }

        // Resize to small size for faster processing
        let size = CGSize(width: 50, height: 50)
        let rect = CGRect(origin: .zero, size: size)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }

        self.draw(in: rect)
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }

        // Get pixel data
        let width = resizedImage.width
        let height = resizedImage.height
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8

        var pixelData = [UInt8](repeating: 0, count: width * height * bytesPerPixel)

        guard let context = CGContext(
            data: &pixelData,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        context.draw(resizedImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        // Calculate average color
        var totalRed: Int = 0
        var totalGreen: Int = 0
        var totalBlue: Int = 0
        var pixelCount: Int = 0

        for y in 0..<height {
            for x in 0..<width {
                let offset = (y * width + x) * bytesPerPixel
                let red = Int(pixelData[offset])
                let green = Int(pixelData[offset + 1])
                let blue = Int(pixelData[offset + 2])

                totalRed += red
                totalGreen += green
                totalBlue += blue
                pixelCount += 1
            }
        }

        let avgRed = CGFloat(totalRed) / CGFloat(pixelCount) / 255.0
        let avgGreen = CGFloat(totalGreen) / CGFloat(pixelCount) / 255.0
        let avgBlue = CGFloat(totalBlue) / CGFloat(pixelCount) / 255.0

        return UIColor(red: avgRed, green: avgGreen, blue: avgBlue, alpha: 1.0)
    }
}

// MARK: - Color Utilities

extension Color {
    /// Calculates relative luminance for WCAG contrast calculations
    var luminance: Double {
        let components = UIColor(self).cgColor.components ?? [0, 0, 0, 1]

        func adjust(_ component: CGFloat) -> Double {
            let c = Double(component)
            return c <= 0.03928 ? c / 12.92 : pow((c + 0.055) / 1.055, 2.4)
        }

        let r = adjust(components[0])
        let g = adjust(components[1])
        let b = adjust(components[2])

        return 0.2126 * r + 0.7152 * g + 0.0722 * b
    }

    /// Determines if white or black text should be used for optimal contrast
    var contrastingTextColor: Color {
        return luminance > 0.5 ? .black : .white
    }

    /// Creates a darkened version of the color for better glass tint effect
    func darkened(by percentage: Double = 0.3) -> Color {
        let uiColor = UIColor(self)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        return Color(
            hue: Double(hue),
            saturation: Double(saturation),
            brightness: Double(brightness) * (1 - percentage)
        )
    }
}

// MARK: - Async Image Color Loading

@MainActor
class ImageColorLoader: ObservableObject {
    @Published var dominantColor: Color?
    @Published var textColor: Color = .white

    func loadColor(from urlString: String) async {
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: data),
                  let dominantUIColor = uiImage.dominantColor() else {
                return
            }

            let color = Color(dominantUIColor).darkened(by: 0.2)
            self.dominantColor = color
            self.textColor = color.contrastingTextColor
        } catch {
            print("Failed to load image color: \(error)")
        }
    }
}
