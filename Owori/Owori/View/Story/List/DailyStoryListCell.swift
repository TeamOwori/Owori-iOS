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
        GeometryReader { geometry in
            HStack {
                DailyStoryText()
                VStack {
                    DailyStoryImageCell()
                    Text("yyyy.MM.dd".stringFromDate())
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .frame(height: geometry.size.height/6)
            }
            .frame(width: geometry.size.width, height: geometry.size.height/6)
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
        }
    }
}

// MARK: PREVIEWS
struct DailyStoryListCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyStoryListCell()
    }
}
