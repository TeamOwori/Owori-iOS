//
//  ProfileText.swift
//  Owori
//
//  Created by 희 on 2023/07/06.
//

import SwiftUI

struct ProfileText: View {
    var nickname: String
    var body: some View {
        Text(nickname)
            .font(Font.custom("Pretendard", size: 12).weight(.medium))
            .kerning(0.18)
            .foregroundColor(Color.oworiGray700)
    }
}

struct ProfileText_Previews: PreviewProvider {
    static var previews: some View {
        ProfileText(nickname: "nickname")
    }
}
