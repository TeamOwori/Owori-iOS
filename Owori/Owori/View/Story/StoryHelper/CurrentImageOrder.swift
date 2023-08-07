//
//  CurrentImageOrder.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/07.
//

import SwiftUI

struct CurrentImageOrder: View {
//    @Binding var images: [String]
    var images: [String]
    @Binding var currentIndex: Int
    
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
        CurrentImageOrder(images: ["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"], currentIndex: .constant(0))
    }
}
