//
//  SelectEmotionBadge.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct SelectEmotionBadge: View {
    var body: some View {
        // 홈/감정뱃지 설정하기 - 아직 구현 전...
        ZStack {
            Color.oworiMainColor
                .ignoresSafeArea(.all)
        }
    }
}

struct SelectEmotionBadge_Previews: PreviewProvider {
    static var previews: some View {
        SelectEmotionBadge()
    }
}
