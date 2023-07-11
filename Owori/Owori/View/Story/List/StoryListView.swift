//
//  StoryListView.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct StoryListView: View {
    // MARK: PROPERTIES
    /// - [임시] 리스트의 갯수
    /// - 실제 데이터 들어오면 없어질 예정
    private var lists = ["1", "2", "3", "4"]
    
    // MARK: BODY
    var body: some View {
        VStack {
            ForEach(lists, id: \.self) { story in
                DailyStoryListCell()
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
                Divider()
                    .frame(height: 1)
                    .overlay(Color.oworiGrayE9E9E9)
            }
        }
    }
}

// MARK: PREVIEWS
struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
