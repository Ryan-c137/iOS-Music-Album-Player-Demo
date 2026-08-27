import Foundation
import SwiftUI
import UIKit
import SwiftData


@Model
final class Album: Identifiable{
    
    var id: UUID
    
    var name: String
    var cover: Data
    var creator: String
    var year: Int
    var rating: Double
    var date: Date = Date()
    
    var color: Color? {
        cover.bOrW() //black or white
    }
    
    init(id: UUID = UUID(), name: String = "Unknown", cover: Data = UIImage(systemName: "photo")!.pngData()!, creator: String = "Unknown", year: Int = 0, rating: Double = 0) {
        self.id = id
        self.name = name
        self.cover = cover
        self.creator = creator
        self.year = year
        self.rating = rating
    }
    
    static var emptyAlbum: Album {
        Album(name: "", cover: UIImage(systemName: "photo")!.pngData()!, creator: "", year: 2000, rating: 0)
    }
}


