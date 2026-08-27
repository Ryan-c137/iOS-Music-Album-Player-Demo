import SwiftUI

struct AlbumCardView: View {
    
    var album: Album
    
    
    var body: some View {
        HStack {
            VStack {
                Image(uiImage: UIImage(data: album.cover)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 140)
                    .border(album.color ?? .red, width: 0.5)
                    .cornerRadius(1)
                    .padding(.top, 25)
                    .padding(.bottom, 5)
                
                HStack {
                    Text("Rating:")
                        .foregroundStyle(album.color ?? .red)
                        .font(.caption)
                        .bold()
                    StarsView(numberOfStars: album.rating, color: album.color ?? .red)
                }
                .padding(.bottom)
            }
            .padding(.vertical)
            .padding(.leading, 20)
            Spacer()
            Text(album.name)
                .multilineTextAlignment(.leading)
                .foregroundStyle(album.color ?? .red)
                .font(.system(size: 40, weight: .heavy, design: .default))
                .frame(width: 200, height: 170)
                .lineLimit(3)
                .padding(.trailing, 8)
        }
        .frame(width: 380, height: 190)
        .background(Image(uiImage: UIImage(data: album.cover)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 500, height: 500)
                        .padding(.bottom, 100)
                        .scaledToFill()
                        .blur(radius: 50)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 1)
        )
        .shadow(radius: 10)
        
    }
}



#Preview {
    AlbumCardView(album: Album.sampleData[4])
}
