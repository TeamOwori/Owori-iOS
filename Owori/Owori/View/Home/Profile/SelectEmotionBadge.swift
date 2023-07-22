//
//  SelectEmotionBadge.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct SelectEmotionBadge: View {
    var body: some View {
//        NavigationStack {
            ZStack {
                Color.oworiMainColor
                    .ignoresSafeArea(.all)
            }
            .navigationBarBackButtonHidden(true)
//        }
    }
}

struct SelectEmotionBadge_Previews: PreviewProvider {
    static var previews: some View {
        SelectEmotionBadge()
    }
}
