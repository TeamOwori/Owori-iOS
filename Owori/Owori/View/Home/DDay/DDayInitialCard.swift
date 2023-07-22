//
//  DDayInitialCard.swift
//  Owori
//
//  Created by 드즈 on 2023/07/23.
//

import SwiftUI

struct DDayInitialCard: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                    // 캘린더/이벤트 작성하기 View
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color.gray/*300*/, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                            )
                        VStack(spacing: 25) {
                            Text("아직 D-day가 없어요\n캘린더에서 D-day를 추가해봐요")
//                                .font(
//                                    Font.custom("Pretendard", size: 14)
//                                )
                                .foregroundColor(.gray)
                                //.padding(25)
                        }
                        .frame(width: 260, height: 140)
                    }
            }
        }
    }
}

struct DDayCard_Previews: PreviewProvider {
    static var previews: some View {
        DDayInitialCard()
    }
}
