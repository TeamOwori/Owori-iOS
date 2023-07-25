//
//  ProfileImage.swift
//  Owori
//
//  Created by 드즈 on 2023/07/23.
//

import SwiftUI

struct ProfileImage: View {
    //@Binding var profiles: [Family.MemberProfile] // 임시 - 프로필 정보
    
    @State private var profiles: [Family.MemberProfile] = [
        Family.MemberProfile(id: "1", nick_name: "홍길동", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue"),
    ]
    
    var body: some View {
        Image(profiles[0].profile_image ?? "")
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
