//
//  StoryDetailView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/06.
//

import SwiftUI

struct StoryDetailView: View {
    @State private var images: [String] = ["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"]
    @State private var currentIndex: Int = 0
    @State private var isFavorite: Bool = true
    
    var body: some View {
        ScrollView {
            VStack {
                ImageTabView(images: $images, currentIndex: $currentIndex)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                    .clipped()
                
                VStack {
                    
                    HorizontalScrollView(images: $images, currentIndex: $currentIndex)
                    VStack {
                        DetailText(isFavorite: $isFavorite)
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView()
    }
}
