//
//  CurrentImageOrder.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/07.
//

import SwiftUI

struct CurrentImageOrder: View {
    @Binding var currentIndex: Int
    var images: [String] = ["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .foregroundColor(Color.oworiDarkGray)
            .frame(width: 47, height: 34)
            .overlay(
                Text("\(currentIndex + 1) / \(images.count)")
                    .foregroundColor(.white)
                    .font(.subheadline)
            )
    }
}

struct CurrentImageOrder_Previews: PreviewProvider {
    static var previews: some View {
        CurrentImageOrder(currentIndex: .constant(0))
    }
}
