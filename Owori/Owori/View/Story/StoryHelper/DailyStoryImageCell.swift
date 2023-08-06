//
//  DailyStoryImageCell.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/03.
//

import SwiftUI

struct DailyStoryImageCell: View {
    // MARK: PROPERTIES
    /// - [임시] dailyImages의 갯수에 따라서 사진이 여러 장인지 아닌지 표시하기 위한 변수
    /// - 실제 이미지가 들어오면 없어질 예정
//    private var numberOfImages: Int = 2
    var storyImage: String
    var storyImagesNumber: Int

    // MARK: BODY
    var body: some View {
        ZStack(alignment: .topTrailing) {
                // Images
                Image("DefaultImage")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                
                // Images의 갯수에 따라 사진이 여러 장인지 아닌지 표시
                if storyImagesNumber > 1 {
                    Image("Layers")
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 8))
            }
        }
        .scaledToFit()
    }
}


// MARK: PREVIEWS
struct DailyStoryImageCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryImageCell(storyImage: "DefaultImage", storyImagesNumber: 2)
    }
}
