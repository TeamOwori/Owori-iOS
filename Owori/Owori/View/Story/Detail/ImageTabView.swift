//
//  ImageTabView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/06.
//

import SwiftUI

struct ImageTabView: View {
    private var indexOfImage: Int = 1
    private var images: [String] = ["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"]
    @State private var currentIndex: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(selection: $currentIndex) {
                ForEach(0 ..< images.count, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }
            }
            CurrentImageOrder(currentIndex: $currentIndex)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct ImageTabView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTabView()
    }
}
