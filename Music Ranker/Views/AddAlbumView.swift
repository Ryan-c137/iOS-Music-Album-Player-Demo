import SwiftUI
import PhotosUI
import UIKit

struct AddAlbumView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var chosenCover: Bool = false
    @State private var album = Album.emptyAlbum
    
    @State private var height: CGFloat = 80
    @State private var expended: Bool = false
    @State private var expandRecorder: Bool = true
    
    var body: some View {
        GeometryReader { geomotry in
            VStack {
                
                ImportFromMusic(expanded: $expended)
                    .frame(height: height)
                    .padding(.top, 50)
                    .simultaneousGesture(TapGesture().onEnded {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.bouncy(duration: 0.2)) {
                                if expended {
                                    height = 200
                                }else {
                                    height = 80
                                }
                            }
                        }
                    })
                
                VStack {
                    Label("Add new ablum manually", systemImage: "square.and.pencil")
                        .scaleEffect(1.2)
                        .padding(.leading, 5)
                        .padding(.bottom, 30)
                        .bold()
                    
                    PhotosPicker(selection: $avatarItem, matching: .images) {
                        if !chosenCover {
                            Image(systemName: "plus.app.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding(.horizontal)
                        }else {
                            avatarImage?
                                .resizable()
                        }
                        
                    }
                    .onChange(of: avatarItem) {
                        Task {
                            if let loaded = try? await avatarItem?.loadTransferable(type: Data.self) {
                                if UIImage(data: loaded) != nil {
                                    avatarImage = Image(uiImage: UIImage(data: loaded)!)
                                    album.cover = loaded
                                }
                            } else {
                                print("Failed")
                            }
                        }
                        chosenCover = true
                    }
                    .frame(width: 200, height: 200)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 1)
                    )
                    .shadow(radius: 10)
                    
                    List {
                        TextField("Name of the album", text: $album.name)
                        TextField("Name of the creator", text: $album.creator)
                        Section(header: Text("Choose the year:")) {
                            Picker("Year of the album", selection: $album.year) {
                                ForEach(1948...2025, id: \.self) { year in
                                    Text("\(String(year))")
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 120)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        if album.name.isEmpty || album.creator.isEmpty || album.year == 0 || !chosenCover {
//                                    errorMessage = "Failed to create album, please fill all the fields"
                        }else {
                            modelContext.insert(album)
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                    }.padding(.horizontal)
                        .scaleEffect(1.2)
                }
            }
            .scrollContentBackground(.hidden)
            
        }
    }
}

#Preview {
    AddAlbumView()
}
