//
//  StoryDetailView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/06.
//

import SwiftUI

struct StoryDetailView: View {
    private var images: [String] = ["TestImage1", "TestImage2", "TestImage3", "TestImage4", "TestImage5", "TestImage6", "TestImage7", "TestImage8", "TestImage9", "TestImage10"]
    
    var body: some View {
        ScrollView {
            ImagesScrollView()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView()
    }
}
