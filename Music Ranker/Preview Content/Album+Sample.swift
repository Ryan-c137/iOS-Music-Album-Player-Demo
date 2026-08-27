import Foundation
import UIKit

extension Album {
    static let sampleData: [Album] = [
        Album(name: "Hit me hard and soft",
              cover: UIImage(imageLiteralResourceName: "HitMeHardAndSoft").pngData()!,
             creator: "Billie Eilish",
             year: 2024,
             rating: 4),
        Album(name: "Deeper Well",
              cover: UIImage(imageLiteralResourceName: "DeeperWell").pngData()!,
              creator: "Kacey Musgraves",
              year: 2024,
              rating: 3.5),
        Album(name: "Oncle Jazz",
              cover: UIImage(imageLiteralResourceName: "OncleJazz").pngData()!,
              creator: "Men I Trust",
              year: 2019,
              rating: 3.5),
        Album(name: "Deeper Well",
              cover: UIImage(imageLiteralResourceName: "DeeperWell").pngData()!,
              creator: "Kacey Musgraves",
              year: 2024,
              rating: 3.5),
        Album(name: "Hit me hard and soft",
              cover: UIImage(imageLiteralResourceName: "HitMeHardAndSoft").pngData()!,
             creator: "Billie Eilish",
             year: 2024,
             rating: 4),
        
    ]
}
