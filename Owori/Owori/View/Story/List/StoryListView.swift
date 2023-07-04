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
        ScrollView {
            ForEach(lists, id: \.self) { story in
                DailyStoryListCell()
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                Divider()
                    .frame(height: 0.5)
                    .overlay(.gray)
                
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
