import SwiftUI
import SwiftData

@main
struct Music_RankerApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: Album.self)
        }
    }
}

