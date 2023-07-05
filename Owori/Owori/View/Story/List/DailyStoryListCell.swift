//
//  DailyStoryListCell.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct DailyStoryListCell: View {
    // MARK: PROPERTIES
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
        VStack {
            HStack {
                DailyStoryText()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                DailyStoryImageCell()
                // ImageCell 크기 처리하는 부분 PM이랑 상의해보기(태블릿 대응)
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            
            HStack {
                Text("좋아요 \(numberOfFavorite)")
                Text("댓글 \(numberOfcomment)")
                Text("• \(author)")
                Spacer()
                // Test용 데이터
                Text("yyyy.MM.dd".stringFromDate() + " ~ " + "yyyy.MM.dd".stringFromDate())
            }
            .foregroundColor(.gray)
            .font(.subheadline)
        }
    }
}


// MARK: PREVIEWS
struct DailyStoryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryListCell()
    }
}
