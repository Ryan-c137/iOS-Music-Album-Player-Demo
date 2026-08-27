//
//  AlbumListView.swift
//  AlbumShelf
//
//  Created by Ryan on 12/09/2025.
//

import SwiftUI
import SwiftData

struct AlbumListView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    var title:String
    
    var albums:[Album]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 5), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                LazyVStack(spacing: 12) {
                    ForEach(Array(albums.prefix(3))) { album in
                        NavigationLink(value: album) {
                            ThinAlbumCardView(album: album)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        withAnimation(.bouncy) {
                                            self.delete(album: album)
                                        }
                                    } label: { Label("Delete", systemImage: "trash") }
                                            Button { /*edit(album)*/ } label: { Label("Edit", systemImage: "pencil") }
                                        }
                        }
                    }
                }
                
                
                if albums.count > 3 {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(Array(albums[3...])) { album in
                            NavigationLink(value: album) {
                                SquareAlbumCardView(album: album)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            withAnimation(.bouncy) {
                                                self.delete(album: album)
                                            }
                                        } label: { Label("Delete", systemImage: "trash") }
                                                Button { /*edit(album)*/ } label: { Label("Edit", systemImage: "pencil") }
                                            }
                            }
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationDestination(for: Album.self) { album in
                ThinAlbumCardView(album: album)
            }
        }
    }
    
    func delete(album: Album) {
        modelContext.delete(album)
        do {
            try modelContext.save()
        } catch {
            print( "Failed to save after delete:", error)
        }
    }
}

#Preview {
    AlbumListView(title: "Title", albums: Album.sampleData)
}
