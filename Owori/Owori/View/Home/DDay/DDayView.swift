//
//  DDay.swift
//  Owori
//
//  Created by 희 on 2023/07/06.
//

import SwiftUI

struct DDayView: View {
    // MARK: dday_option 대응 필요
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    @State private var ddayInfos: [Family.Schedule] = [
        Family.Schedule(id: "1", title: "장보기", start_datd: "2023-07-05", end_date: "2023/07/16", schedule_type: "", member_nickname: "고삼이", color: "FFFFFF", alarm_option: nil, dday_option: true, dday: "D-Day"),
        Family.Schedule(id: "2", title: "장보기", start_datd: "2023-07-05", end_date: "2023/07/25", schedule_type: "", member_nickname: "고삼이", color: "FFFFFF", alarm_option: nil, dday_option: false, dday: "D-Day"),
        Family.Schedule(id: "3", title: "장보기", start_datd: "2023-07-05", end_date: "2023/07/26", schedule_type: "", member_nickname: "고삼이", color: "FFFFFF", alarm_option: nil, dday_option: true, dday: "D-Day"),
        Family.Schedule(id: "4", title: "전시회", start_datd: "2023-07-05", end_date: "2023/07/26", schedule_type: "", member_nickname: "고삼이", color: "FFFFFF", alarm_option: nil, dday_option: true, dday: "D-Day"),
        Family.Schedule(id: "5", title: "장보기", start_datd: "2023-07-05", end_date: "2023/07/26", schedule_type: "", member_nickname: "고삼이", color: "FFFFFF", alarm_option: nil, dday_option: true, dday: "D-Day")
    ]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 16){
                ForEach(0..<ddayInfos.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .center) {
                            Text(ddayInfos[index].dday ?? "")
                                .font(Font.custom("Pretendard", size: 18)  .weight(.semibold))
                            Spacer()
                            Button {
                                // 디데이 카드 삭제
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color.oworiGray300)
                            }
                        }
                        .frame(width: 204, alignment: .center)
                        Text(ddayInfos[index].end_date ?? "") // 임시
                            .font(Font.custom("Pretendard", size: 12))
                            .kerning(0.18)
                        Text(ddayInfos[index].title ?? "")
                            .font(Font.custom("Pretendard", size: 16).weight(.semibold))
                            .frame(width: 204, height: 54, alignment: .topLeading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.06), radius: 6, x: -4, y: 5)
                    .shadow(color: .black.opacity(0.1), radius: 7, x: 4, y: 2)
                    .frame(width: 240, height: UIScreen.main.bounds.height * 0.15, alignment: .leading)
                    
                }
            }
            .padding(.horizontal, 15)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
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

struct DDayView_Previews: PreviewProvider {
    static var previews: some View {
        DDayView()
    }
}
