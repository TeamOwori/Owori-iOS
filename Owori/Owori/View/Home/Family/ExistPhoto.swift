//
//  ExistPhoto.swift
//  Owori
//
//  Created by 드즈 on 2023/07/23.
//

import SwiftUI

struct ExistPhoto: View {
    // 임시 - 배열에서 클릭된 인덱스의 image_name 데이터
    @State var imageName: String = "TestImage1"
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .navigationBarTitle(Text(imageName), displayMode: .inline)
    }
}

struct ExistPhoto_Previews: PreviewProvider {
    static var previews: some View {
        ExistPhoto()
    }
}
