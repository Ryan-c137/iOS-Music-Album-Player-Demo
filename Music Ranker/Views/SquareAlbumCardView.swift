//
//  SquareAlbumCardView.swift
//  AlbumShelf
//
//  Created by Ryan on 12/09/2025.
//

import SwiftUI

struct SquareAlbumCardView: View {
    var album: Album
    
    
    var body: some View {
        
        Image(uiImage: UIImage(data: album.cover)!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .overlay(content: {
                Image(uiImage: UIImage(data: album.cover)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .blur(radius: 15, opaque: true)
                            .mask(
                                Rectangle()
                                    .frame(height: 80)
                                    .offset(y: 60)
                            )
                Text(album.name)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(album.color ?? .white)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .lineLimit(2)
                    .padding()
                    .offset(y:45)
                            
            })
            .cornerRadius(10)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 1)
            })
            .shadow(radius: 10)
            .padding()
        
    }
}

#Preview {
    SquareAlbumCardView(album: Album.sampleData[0])
}

