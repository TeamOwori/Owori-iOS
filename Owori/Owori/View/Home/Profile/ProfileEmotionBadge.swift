//
//  ProfileEmotionBadge.swift
//  Owori
//
//  Created by 희 on 2023/07/23.
//

import SwiftUI

struct ProfileEmotionBadge: View {
    @State private var profiles: [Family.MemberProfile] = [
        Family.MemberProfile(id: "1", nick_name: "홍길동", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue")]
    var emotionalBadge: String
    
    var body: some View {
        Image(emotionalBadge)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 18, height: 18)
            .clipped()
    }
}

struct ProfileEmotionBadge_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEmotionBadge(emotionalBadge: "squinting-face-with-tongue")
    }
}
