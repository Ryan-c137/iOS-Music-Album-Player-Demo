//
//  ImportFromMusic.swift
//  Music Ranker
//
//  Created by Ryan on 27/06/2025.
//

import Foundation
import SwiftUI
import SwiftData

struct ButtonParameters {
    var text: String
    var offset: [CGFloat]
    var width: CGFloat
}

struct ImportFromMusic: View {
    
    @State private var buttonParemeters = ButtonParameters(text: "Import from Apple Music", offset: [2, 8], width: 350)
    @Binding var expanded: Bool
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var urlText: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                if !expanded {
                    Button(buttonParemeters.text, systemImage: "square.and.arrow.down") {
                        withAnimation(.linear(duration: 0.2)) {
                            buttonParemeters.text = "Import"
                            buttonParemeters.offset = [1.33,1.3]
                            buttonParemeters.width = 130
//                            height = 3
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.linear(duration: 0.2)) {
                                expanded.toggle()
                            }
                        }
                    }
                    .scaleEffect(1.2)
                    .frame(width: buttonParemeters.width, height: 50)
                    .background(Color(red: 150/256, green: 205/256, blue: 255/256))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .shadow(radius: 5)
                    .position(x: geometry.size.width / buttonParemeters.offset[0], y: geometry.size.height / buttonParemeters.offset[1])
                }else {
                    TextField("Link of album from Apple Music", text: $urlText)
                        .padding()
                        .frame(width: 350, height: 50)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 8)
//                        .transition(.slide)
                    
                    Button("Cancel", systemImage: "xmark.circle") {
                        withAnimation(.linear(duration: 0.2)) {
                            buttonParemeters.text = "Import from Apple Music"
                            buttonParemeters.offset = [2,8]
                            buttonParemeters.width = 350
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.linear(duration: 0.2)) {
                                expanded.toggle()
                            }
                        }
                    }
                    .foregroundColor(.red)
                    .scaleEffect(1.2)
                    .frame(width: 130, height: 50)
                    .background(.gray.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .shadow(radius: 5)
                    .position(x: geometry.size.width / 4, y: geometry.size.height / 1.3)
                    
                    Button(isLoading ? "..." : buttonParemeters.text, systemImage: "square.and.arrow.down") {
                        guard !urlText.isEmpty, let url = URL(string: urlText) else {
                            errorMessage = "Please enter a valid URL"
                            return
                        }
                        
                        isLoading = true
                        errorMessage = nil
                        
                        Task {
                            do {
                                let album = try await Album.createFromUrl(url)
                                album.date = Date()
                                modelContext.insert(album)
                                try modelContext.save()
                                isLoading = false
                                dismiss()
                            } catch {
                                isLoading = false
                                errorMessage = "Failed to create album: \(error.localizedDescription)"
                            }
                        }
                    }
                    .scaleEffect(1.2)
                    .frame(width: buttonParemeters.width, height: 50)
                    .background(Color(red: 150/256, green: 205/256, blue: 255/256))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .shadow(radius: 5)
                    .position(x: geometry.size.width / buttonParemeters.offset[0], y: geometry.size.height / buttonParemeters.offset[1])
                    .disabled(isLoading || urlText.isEmpty)
                }
                
            }
        }
    }
}

//#Preview {
//    ImportFromMusic(expanded: <#T##Binding<Bool>#>)
//}
