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
    
    // 임시 - 디데이 정보 변수
    var ddayInfos = [
        DDay.DdayInfo(id: "1", dday: "안녕", text: "하이"),
        DDay.DdayInfo(id: "2", dday: "안녕", text: "하이"),
        DDay.DdayInfo(id: "3", dday: "안녕", text: "하이"),
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.oworiMainColor
                ForEach(0..<ddayInfos.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Text(ddayInfos[index].dday)
                                .font(
                                    Font.custom("Pretendard", size: 18)
                                        .weight(.semibold)
                            )
                            Spacer()
                            Button {
                                // 디데이 카드 삭제
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color.oworiGray300)
                            }
                        }
                        .frame(width: 204, alignment: .center)
                        Text("7월 22일 (토)") // 임시
                            .font(Font.custom("Pretendard", size: 12))
                            .kerning(0.18)
                        Text(ddayInfos[index].text)
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
                                currentIndex = min(ddayInfos.count - 1, currentIndex + 1)
                            }
                        }
                    }
            )
        }
    }
}

struct DDayView_Previews: PreviewProvider {
    static var previews: some View {
        DDayView()
    }
}
