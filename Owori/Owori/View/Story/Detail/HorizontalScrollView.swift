//
//  HorizontalScrollView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/10.
//

import SwiftUI

struct HorizontalScrollView: View {
    @Binding var images: [String]
    @Binding var currentIndex: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< images.count, id: \.self) { index in
                    Button {
                        currentIndex = index
                    } label: {
                        VStack(spacing: 0) {
                            VStack {
                                DetailImageCell(image: images[index])
                                    .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6 * 4 / 5)
                                    .clipped()
                            }
                            VStack {
                                Rectangle()
                                    .foregroundColor(currentIndex == index ? .oworiOrange : .clear)
                                    .frame(height: 4)
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        }
    }
}

struct HorizontalScrollView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollView(images: .constant(["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"]), currentIndex: .constant(0))
    }
}
