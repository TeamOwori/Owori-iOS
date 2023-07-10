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
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

struct DetailImageCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageCell(image: "TestImage1")
    }
}
