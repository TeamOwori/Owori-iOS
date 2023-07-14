//
//  FamilyPhoto.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct FamilyPhoto: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 300, height: 180)
            VStack(spacing: 25) {
                Text("사진 자유롭게 올리는 공간이에요!\n가족사진을 올려보는건 어떨까요?")
                    //.font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.gray)
                    //.padding(25)
                Image("Plus")
            }
            .frame(width: 260, height: 140)
        }
    }
}

struct FamilyPhoto_Previews: PreviewProvider {
    static var previews: some View {
        FamilyPhoto()
    }
}
