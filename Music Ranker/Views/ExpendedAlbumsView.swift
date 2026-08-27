import SwiftUI

struct ExpendedAlbumsView: View {
    
    var albums: [Album]
    
    var body: some View {
        ScrollView(.vertical) {
            HStack {
                Text("Albums")
                    .multilineTextAlignment(.leading)
                    .bold()
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                Spacer()
            }
            
            LazyVStack(spacing: 15) {
                ForEach(albums) { album in
                    AlbumCardView(album: album)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ExpendedAlbumsView(albums: Album.sampleData)
}

