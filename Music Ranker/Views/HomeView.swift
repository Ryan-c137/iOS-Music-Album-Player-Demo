import SwiftUI
import Foundation
import SwiftData

struct HomeView: View {
    
    @Query private var albums: [Album]
    
    @State var isPresented = false
//    private var active = true
    
    var body: some View {
        NavigationStack {
            VStack {
                
                NavigationLink(
                    destination: AlbumListView(title: "My Favourites", albums: albums.sorted { ($0.rating, $0.date) < ($1.rating, $1.date) })
                ) {
                    AlbumStackView(title: "My Favourites", albums: albums.sorted { ($0.rating, $0.date) < ($1.rating, $1.date) })
                        .padding()
                }
                .disabled(albums.count == 0 ? true: false)
                .simultaneousGesture(TapGesture().onEnded {
                    if albums.count == 0 ? true: false {
                        isPresented = !isPresented
                    }
                })
                
                NavigationLink(
                    destination: AlbumListView(title: "Recently Added", albums: albums.sorted { $0.date > $1.date })
                ) {
                    AlbumStackView(title: "Recently Added", albums: albums.sorted { $0.date > $1.date })
                        .padding()
                }
                .disabled(albums.count == 0 ? true: false)
                .simultaneousGesture(TapGesture().onEnded {
                    if albums.count == 0 ? true: false {
                        isPresented = !isPresented
                    }
                })
                
                Spacer()
            }
            .navigationTitle("Albums")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Add") {
                        isPresented = !isPresented
                    }
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            AddAlbumView()
                .presentationDetents([.large])
        }
    }
    
    
//    var durationTime: Double = 0.3
//    var xAxis = CGFloat(11)
//    
//    @State private var expand = false
//    
//    @State private var isPresented = false
//    
//    @State private var cardsOffset = [54, 54, 74, 109]
//    
//    @State private var opacity = 1.0
//    
//    @Query private var albums: [Album]
//    
//    var body: some View {
//        VStack {
//            
//            ZStack(alignment: .topLeading) {
//                ZStack {
//                    if !expand && albums.endIndex-4>=0 {
//                        AlbumCardView(album: albums[albums.endIndex-4])
//                            .offset(x: xAxis,y: CGFloat(cardsOffset[0]))
//                    }
//                    if !expand && albums.endIndex-3>=0 {
//                        AlbumCardView(album: albums[albums.endIndex-3])
//                            .offset(x: xAxis,y: CGFloat(cardsOffset[1]))
//                    }
//                    if !expand && albums.endIndex-2>=0 {
//                        AlbumCardView(album: albums[albums.endIndex-2])
//                            .offset(x: xAxis,y: CGFloat(cardsOffset[2]))
//                    }
//                    if !expand && albums.endIndex-1>=0 {
//                        AlbumCardView(album: albums[albums.endIndex-1])
//                            .offset(x: xAxis,y: CGFloat(cardsOffset[3]))
//                    }
//                }
//                .onTapGesture {
//                    withAnimation(.easeOut(duration: durationTime)) {
//                        cardsOffset[0] = 669
//                        cardsOffset[3] = 54
//                        cardsOffset[2] = 259
//                        cardsOffset[1] = 464
//                        opacity = 0
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + durationTime) {
//                        expand = true
//                    }
//                }
//                
//                if !expand {
//                    HStack {
//                        Text("Albums")
//                            .multilineTextAlignment(.leading)
//                            .bold()
//                            .font(.system(size: 30, weight: .heavy, design: .default))
//                            .padding(.leading, 20)
//                            .padding(.bottom, 20)
//                        Spacer()
//                        Button("Add", systemImage: "plus") {
//                            withAnimation(.bouncy) {
//                                isPresented.toggle()
//                            }
//                        }.padding(.trailing, 30)
//                        .padding(.bottom, 10)
//                        .scaleEffect(isPresented ? 1.4 : 1.3)
//                        .opacity(opacity)
//                    }
//                }
//                
//                
//            }
//
//            if !expand {
//                Spacer()
//            }
//            
//            //after expend
//            
//            if expand {
//                ExpendedAlbumsView(albums: albums)
//            }
//        }.sheet(isPresented: $isPresented) {
//            AddAlbumView()
//                .presentationDetents([.large])
//        }
//    }
}

#Preview {
    HomeView()
}
