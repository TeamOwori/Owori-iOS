//
//  ProfileText.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct ProfileText: View {
    // MARK: 최대 7글자
    //@Binding var profiles: [Family.MemberProfile] // 임시 - 프로필 정보
    @State private var profiles: [Family.MemberProfile] = [
        Family.MemberProfile(id: "1", nick_name: "1234567", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue"),
    ]
    
    var body: some View {
        Text(profiles[0].nick_name ?? "")
            .font(Font.custom("Pretendard", size: 12).weight(.medium))
            .kerning(0.18)
            .foregroundColor(Color.oworiGray700)
    }
}

struct ProfileText_Previews: PreviewProvider {
    static var previews: some View {
        ProfileText()
    }
}
