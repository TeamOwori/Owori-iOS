//
//  ProfileEmotionBadge.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct ProfileEmotionBadge: View {
    var body: some View {
        // 임시 감정 이모티콘 이미지
        Image("squinting-face-with-tongue")
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
