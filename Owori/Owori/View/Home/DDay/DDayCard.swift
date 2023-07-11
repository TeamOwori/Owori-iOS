//
//  DDayCard.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct DDayCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.yellow)
                .frame(width: 300, height: 180)
            Text("아직 D-day가 없어요\n캘린더에서 D-day를 추가해봐요")
//                .font(Font.custom("Pretendard", size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        }
    }
}

struct DDayCard_Previews: PreviewProvider {
    static var previews: some View {
        DDayCard()
    }
}
