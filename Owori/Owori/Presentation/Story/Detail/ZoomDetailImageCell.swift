//
//  ZoomDetailImageCell.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/09.
//

import SwiftUI

struct ZoomDetailImageCell: View {
    var image: String
    var body: some View {
        AsyncImage(url: URL(string: image)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Image("DefaultImage")
        }
        .onAppear {
        }
    }
}

struct ZoomDetailImageCell_Previews: PreviewProvider {
    static var previews: some View {
        ZoomDetailImageCell(image: "DefaultImage")
    }
}
