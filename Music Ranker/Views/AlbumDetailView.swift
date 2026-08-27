//
//  AlbumDetailView.swift
//  AlbumShelf
//
//  Created by Ryan on 12/09/2025.
//

import SwiftUI

struct AlbumDetailView: View {
    
    var album:Album
    
    var body: some View {
//        GeometryReader { geometry in
//
//        }
        
        Image(uiImage: UIImage(data: album.cover)!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 200)
            .border(album.color ?? .red, width: 0.5)
            .cornerRadius(1)
    }
}

#Preview {
    AlbumDetailView(album: Album.sampleData[0])
}
