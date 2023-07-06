//
//  StoryAlbumView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct StoryAlbumView: View {
    // MARK: PROPERTIES
    /// - [임시] 컬렉션의 갯수
    /// - 실제 데이터 들어오면 없어질 예정
    private var collections = ["1", "2", "3", "4"]
    
    // MARK: BODY
    var body: some View {
        VStack {
            ForEach(collections, id: \.self) { collection in
                MonthlyStoryCollection()
                Divider()
                    .frame(height: 1)
                    .overlay(Color.oworiGray)
            }
        }
    }
}

// MARK: PREVIEWS
struct StoryAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        StoryAlbumView()
    }
}
