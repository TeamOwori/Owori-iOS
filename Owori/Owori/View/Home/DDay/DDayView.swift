//
//  DDay.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct DDayView: View {
    // + CalendarView에서 디데이 기능 선택 여부
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isDetailActive = false
    @State private var isDdayisOn = false
    @State private var ddays = [
        DdayInfo(dday: "안성기", date: "1952", text: "고삼이 생일파티 아웃백에서"),
        DdayInfo(dday: "이정재", date: "1972", text: "오늘의 점심은 스파게티"),
        DdayInfo(dday: "김혜자", date: "1941", text: "나는 왜 여기에 있을까?"),
        DdayInfo(dday: "전지현", date: "1981", text: "오랜만에 옆집 강아지를 만났다!"),
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.oworiMainColor
                ForEach(0..<ddays.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Text(ddays[index].dday)
                                .font(
                                    Font.custom("Pretendard", size: 18)
                                        .weight(.semibold)
                            )
                            Spacer()
                        }
                        .frame(width: 204, alignment: .center)
                        Text(ddays[index].dday)
                            .font(Font.custom("Pretendard", size: 12))
                            .kerning(0.18)
                        Text(ddays[index].text)
                            .font(
                                Font.custom("Pretendard", size: 16)
                                    .weight(.semibold)
                            )
                            .frame(width: 204, height: 54, alignment: .topLeading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.06), radius: 6, x: -4, y: 5)
                    .shadow(color: .black.opacity(0.1), radius: 7, x: 4, y: 2)
                    .offset(x: CGFloat(index - currentIndex) * 250 /* 300 */ + dragOffset, y: 0)
                    .onTapGesture {
                        isDetailActive = true
                    }
                }
//                NavigationLink(isActive: $isDetailActive) {
//
//                } label: {
//                    EmptyView()
//                }
            }
            .gesture(
                DragGesture()
                    .onEnded{ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(ddays.count - 1, currentIndex + 1)
                            }
                        }
                    }
            )
        }
    }
}

//struct DDayView: View {
//    var body: some View {
//        DDayCard()
//    }
//}

struct DDayView_Previews: PreviewProvider {
    static var previews: some View {
        DDayView()
    }
}
