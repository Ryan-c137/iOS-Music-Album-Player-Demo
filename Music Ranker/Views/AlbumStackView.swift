//
//  AlbumStackView.swift
//  Music Ranker
//
//  Created by Ryan on 08/09/2025.
//

import SwiftUI

struct AlbumStackView: View {
    
    let title:String
    
    let albums:[Album]
    
    var body: some View {
        VStack {
            HStack {
                Text(title).font(.title2).bold().padding(.leading)
                Spacer()
            }
            ZStack {
                if albums.count <= 1 {
                    GreyCard()
                        .scaledToFit()
                        .scaleEffect(0.8)
                        .offset(x: 15, y: -10)
                }else {
                    AlbumCardView(album: albums[1])
                        .scaledToFit()
                        .scaleEffect(0.8)
                        .offset(x: 15, y: -10)
                }
                if albums.count == 0 {
                    AddCard()
                        .scaledToFit()
                        .scaleEffect(0.8)
                        .offset(x: -15, y: 10)
                }else {
                    AlbumCardView(album: albums[0])
                        .scaledToFit()
                        .scaleEffect(0.8)
                        .offset(x: -15, y: 10)
                }
                
            }
        }
        
    }
}

#Preview {
    AlbumStackView(title: "Recently Added ", albums: Album.sampleData)
}
