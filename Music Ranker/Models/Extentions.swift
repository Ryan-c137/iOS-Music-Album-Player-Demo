import UIKit
import Foundation
import SwiftUI

extension Data {
    func bOrW() -> Color? {
        guard let cgImage = UIImage(data: self)?.cgImage else { return nil }
        
        let width = cgImage.width
        let height = cgImage.height
        let bitsPerComponent = 8
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        let totalBytes = height * bytesPerRow
        
        var data: [UInt8] = Array(repeating: 0, count: totalBytes)
        
        guard let context = CGContext(data: &data,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        else { return nil}
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        var totalLuminance: Double = 0.0
        var pixelCount: Double = 0.0
        
        let step = 10
        for y in stride(from: 0, to: height, by: step) {
            for x in stride(from: 0, to: width, by: step) {
                let index = (y * width + x) * bytesPerPixel
                let red = Double(data[index]) / 255.0
                let green = Double(data[index + 1]) / 255.0
                let blue = Double(data[index + 2]) / 255.0
                let alpha = Double(data[index + 3]) / 255.0
                if alpha > 0 {
                    let luminance = 0.299 * red + 0.587 * green + 0.114 * blue
                    totalLuminance += luminance
                    pixelCount += 1
                }
            }
        }
        
        let averageLuminance:Double? = pixelCount > 0 ? totalLuminance / pixelCount : nil
        
        if averageLuminance! > 0.6 {
            return Color.black
        }else {
            return Color.white
        }
    }
}

extension Album {
    @MainActor
    public static func createFromUrl(_ url: URL) async throws -> Album {
        // Fetch HTML content
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let html = String(data: data, encoding: .utf8) else {
            throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: "Failed to decode HTML content"])
        }

        // Initialize default values
        var name = "Unknown Album"
        var artist = "Unknown Artist"
        var year = 2025
        var coverData: Data = UIImage(systemName: "photo")!.pngData()!

        // Regular expressions for meta tags
        let pattern = "<meta name=\"description\" content=\"Listen to (.*?)\\s+by\\s+(.*?)\\s+on Apple Music.\\s+(.*?)\\s+"
        
        let imagePattern = "<meta property=\"og:image\" content=\"(.*?)\">"

        // Helper function to extract value using regex
        func extractValues(pattern: String, from text: String) -> [String]? {
            guard let regex = try? NSRegularExpression(pattern: pattern),
                  let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)) else {
                return nil
            }
            var results: [String] = []
            for i in 1..<match.numberOfRanges {
                if let range = Range(match.range(at: i), in: text) {
                    results.append(String(text[range]))
                }
            }
            return results.isEmpty ? nil : results
        }

        // Extract metadata
        if let titleValue = extractValues(pattern: pattern, from: html), titleValue.count > 2 {
            name = titleValue[0]
            artist = titleValue[1]
            year = Int(titleValue[2].prefix(4))!

        }
        
        if let coverUrlString = extractValues(pattern: imagePattern, from: html),
           let coverUrl = URL(string: coverUrlString.first!) {
            // Download cover image
            let (imageData, _) = try await URLSession.shared.data(from: coverUrl)
            coverData = imageData
        }

        // Create and return Album instance
        return Album(
            name: name,
            cover: coverData,
            creator: artist,
            year: year,
            rating: 0
        )
    }
}

