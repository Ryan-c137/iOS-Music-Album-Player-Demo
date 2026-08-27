//
//  AddCard.swift
//  Music Ranker
//
//  Created by Ryan on 08/09/2025.
//

import SwiftUI

struct AddCard: View {
    
    var body: some View {
        Image(systemName: "plus.app.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .padding(.horizontal)
            .frame(width: 380, height: 190)
            .foregroundColor(.blue)
            .background(Color.gray.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 1)
            )
            .shadow(radius: 10)
    }
}

#Preview {
    AddCard()
}
