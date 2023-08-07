//
//  DetailImageCell.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/10.
//

import SwiftUI

struct DetailImageCell: View {
    var image: String
    var body: some View {
        AsyncImage(url: URL(string: "https://owori.s3.ap-northeast-2.amazonaws.com/story/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2023-07-22+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+5.36.48.png")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Image("TestImage1")
        }
    }
}

struct DetailImageCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageCell(image: "DefaultImage")
    }
}
