//
//  ThinAlbumCardView.swift
//  AlbumShelf
//
//  Created by Ryan on 12/09/2025.
//

import SwiftUI

struct ThinAlbumCardView: View {
    var album: Album
    
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: album.cover)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .border(album.color ?? .white, width: 0.5)
                .cornerRadius(1)
                .padding()
            VStack {
                Text(album.name)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(album.color ?? .white)
                    .font(.system(size: 30, weight: .heavy, design: .default))
                    .lineLimit(1)
                
                HStack {
                    Text("Rating:")
                        .foregroundStyle(album.color ?? .red)
                        .font(.caption)
                        .bold()
                    StarsView(numberOfStars: album.rating, color: album.color ?? .red)
                }
            }
            .frame(width: 180)
            .padding()
        }
        .frame(width: 360, height: 130)
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
    ThinAlbumCardView(album: Album.sampleData[4])
}
