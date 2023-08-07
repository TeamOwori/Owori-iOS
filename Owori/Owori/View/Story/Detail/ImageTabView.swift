//
//  ImagesScrollView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/06.
//

import SwiftUI

struct ImageTabView: View {
//    @Binding var images: [String]
    var images: [String]
    @Binding var currentIndex: Int
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(selection: $currentIndex) {
                ForEach(images, id: \.self) { image in
                    NavigationLink {
                        ZoomImages()
                    } label: {
                        DetailImageCell(image: image)
                    }
                }
            }
            if !images.isEmpty {
                CurrentImageOrder(images: images, currentIndex: $currentIndex)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct ImagesScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTabView(images: ["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"], currentIndex: .constant(0))
    }
}
