//
//  DailyStoryListCell.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct DailyStoryListCell: View {
    // MARK: PROPERTIES
    
    // MARK: BODY
    var body: some View {
        HStack {
            DailyStoryText()
            VStack {
                DailyStoryImageCell()
                // ImageCell 크기 처리하는 부분 PM이랑 상의해보기(태블릿 대응)
                    .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                
                Text("yyyy.MM.dd".stringFromDate())
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
        }
    }
}


// MARK: PREVIEWS
struct DailyStoryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryListCell()
    }
}
