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
    private var numberOfImages: Int = 2

    // MARK: BODY
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                // Images
                Image(systemName: "person.crop.square.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                
                // Images의 갯수에 따라 사진이 여러 장인지 아닌지 표시
                if numberOfImages > 1 {
                    Image(systemName: "square.fill.on.square.fill")
                        .resizable()
                        .frame(width: geometry.size.width * 0.07, height: geometry.size.height * 0.07)
                        .foregroundColor(.white)
                        .offset(x: geometry.size.width * 0.90, y: geometry.size.height / 30)
                }
            }
        }
        .scaledToFit()
    }
}


// MARK: PREVIEWS
struct DailyStoryImageCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryImageCell()
    }
}
