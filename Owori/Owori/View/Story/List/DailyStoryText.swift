//
//  DailyStoryText.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct DailyStoryText: View {
    // MARK: PROPERTIES
    /// - [임시] 제목 데이터
    /// - 실제 이미지가 들어오면 없어질 예정
    private var titleText: String = "기다리고 기다리던 하루"
    
    /// - [임시] 제목 데이터
    /// - 실제 이미지가 들어오면 없어질 예정
    private var contentText: String = "종강하면 동해바다로 가족여행가자고 한게 엊그제같았는데...3박 4일 동해여행 너무 재미 어쩌구저쩌구 더 길어야돼"
    
    /// - [임시] 좋아요 수 데이터
    /// - 실제 이미지가 들어오면 없어질 예정
    private var numberOfFavorite: Int = 4
    
    /// - [임시] 댓글 수 데이터
    /// - 실제 이미지가 들어오면 없어질 예정
    private var numberOfcomment: Int = 2
    
    /// - [임시] 작성자 데이터
    /// - 실제 이미지가 들어오면 없어질 예정
    private var author: String = "쥐렁이"
    
    // MARK: BODY
    var body: some View {
        VStack(alignment: .leading) {
            Text(titleText)
                .font(.title3)
                .bold()
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                .lineLimit(1)
            Text(contentText)
                .font(.body)
                .foregroundColor(.gray)
                .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
                .lineLimit(2)
            HStack {
                Text("좋아요 \(numberOfFavorite)")
                Text("댓글 \(numberOfcomment)")
                Text("• \(author)")
            }
            .foregroundColor(.gray)
            .padding(EdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0))
            .font(.footnote)
            
        }
    }
}

// MARK: PREVIEWS
struct DailyStoryText_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryText()
    }
}
