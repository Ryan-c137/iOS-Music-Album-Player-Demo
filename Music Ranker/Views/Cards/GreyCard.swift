//
//  GreyCard.swift
//  Music Ranker
//
//  Created by Ryan on 08/09/2025.
//

import SwiftUI

struct GreyCard: View {
    var body: some View {
        Spacer()
        .frame(width: 380, height: 190)
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white, lineWidth: 1)
        )
        .shadow(radius: 10)
        
    }
}

#Preview {
    GreyCard()
}
