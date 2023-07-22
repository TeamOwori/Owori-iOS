//
//  ProfileImage.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct ProfileImage: View {
    // 임시 프로필 이미지 정보: User.member_profile.nickname과 연동 예정
    @State var imageName: String = "TestImage2"
    
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage()
    }
}
