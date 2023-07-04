//
//  MonthlyStoryCollection.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/03.
//

import SwiftUI

struct MonthlyStoryCollection: View {
    // MARK: PROPERTIES
    
    /// - [임시] 모델의 이미지를 대신하기 위한 변수
    /// - 실제 데이터 들어오면 없어질 예정
    private let images = ["1", "2", "3", "4", "5"]
    
    /// - 표시할 열의 수
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    // MARK: BODY
    var body: some View {
        VStack(alignment: .leading) {
            // 날짜
            Text("yyyy.MM".stringFromDate())
                .font(.title3)
                .bold()
            
            // Album Collection View
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(images[0 ..< images.count], id: \.self) { imageName in
                    DailyStoryImageCell()
                        .frame(width: UIScreen.main.bounds.width * 0.30, height: UIScreen.main.bounds.width * 0.30)
                }
            }
        }
    }
}


// MARK: PREVIEWS
struct MonthlyStoryCollection_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyStoryCollection()
    }
}
