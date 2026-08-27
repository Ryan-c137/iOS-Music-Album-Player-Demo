import SwiftUI

struct StarsView: View {
    
    let numberOfStars: Double
    
    let color: Color
    
    var numberOfFullStars: Int {
        Int(numberOfStars)
    }
    
    var numberOfHalfStars: Int {
        numberOfStars == Double(numberOfFullStars) ? 0 : 1
    }
    
    var numberOfEmptyStars: Int {
        5 - (numberOfFullStars + numberOfHalfStars)
    }
    
    var stars: [String] {
        var result: [String] = []
        for _ in 0..<numberOfFullStars {
            result.append("star.fill")
        }
        
        for _ in 0..<numberOfHalfStars {
            result.append("star.leadinghalf.filled")
        }
        
        for _ in 0..<numberOfEmptyStars {
            result.append("star")
        }
        return result
    }
    
    
    var body: some View {
        HStack {
            ForEach(stars, id: \.self) { star in
                Image(systemName: star)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 11, height: 11)
                    .foregroundColor(color)
            }
        }
            
    }
}

#Preview(traits: .fixedLayout(width: 400, height: 10)) {
    StarsView(numberOfStars: 3, color: .yellow)
}
