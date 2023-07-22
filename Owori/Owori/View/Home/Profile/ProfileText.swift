//
//  ProfileText.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct ProfileText: View {
    // 임시 프로필 닉네임 정보
    @State var nickName: String = "name"
    
    var body: some View {
        Text(nickName)
            .font(
                Font.custom("Pretendard", size: 12)
                    .weight(.medium)
            )
            .kerning(0.18)
    }
}

struct ProfileText_Previews: PreviewProvider {
    static var previews: some View {
        ProfileText(nickName: "name")
    }
}
