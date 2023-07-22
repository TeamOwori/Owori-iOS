//
//  ProfileEmotionBadge.swift
//  Owori
//
//  Created by 드즈 on 2023/07/23.
//

import SwiftUI

struct ProfileEmotionBadge: View {
    // 프로필 감정 뱃지 정보
    @State var profileBadge: String = "squinting-face-with-tongue"
    
    var body: some View {
        // 임시 감정 이모티콘 이미지
        Image(profileBadge)
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
