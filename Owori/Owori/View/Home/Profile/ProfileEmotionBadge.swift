//
//  ProfileEmotionBadge.swift
//  Owori
//
//  Created by 드즈 on 2023/07/23.
//

import SwiftUI

struct ProfileEmotionBadge: View {
    //@Binding var profiles: [Family.MemberProfile] // 임시 - 프로필 정보
    @State private var profiles: [Family.MemberProfile] = [
        Family.MemberProfile(id: "1", nick_name: "홍길동", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue"),
    ]
    
    var body: some View {
        // 임시 감정 이모티콘 이미지
        Image(profiles[0].emotional_badge ?? "")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 18, height: 18)
            .clipped()
    }
}

struct ProfileEmotionBadge_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEmotionBadge()
    }
}
