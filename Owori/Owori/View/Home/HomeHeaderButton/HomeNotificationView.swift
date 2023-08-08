//
//  HomeNotificationView.swift
//  Owori
//
//  Created by 신예진 on 8/7/23.
//

import SwiftUI

struct HomeNotificationView: View {
    
    // MARK: PROPERTIES
    /// - [임시] 리스트의 갯수
    /// - 실제 데이터 들어오면 없어질 예정
    private var lists = ["1", "2", "3"]
    
    // MARK: PROPERTIES
    private var Images = ["Message1","Message2","Message3"]
    
    //메시지 보낸 사람
    private var sender = ["지렁이 님이 메시지를 보냈습니다","우당탕탕 우리 가족이 메시지를 보냈습니다","닉네임 님이 메시지를 보냈습니다"]
    // 메시지 내용
    private var messages = ["나 대신 택배 받아줘","나 상탔어!!!","하와이 여행! 인천공항 오후 5시까지 도착해야함!! 다들여권 꼭 챙겨!"]
    // 날짜,시간
    private var date = "05/21 12:34"
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 30){
            
            ForEach(0..<lists.count, id: \.self) { index in
                
                HStack(spacing: 16) {
                    
                    Image(Images[index])
                        .resizable()
                        .frame(width: 20, height: 20)
                        .offset(y: -20)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(sender[index])
                            .font(.headline)
                            .foregroundColor(Color.oworiGray700)
                        
                        Text(messages[index])
                            .font(.body)
                            .foregroundColor(Color.oworiGray700)
                        
                        Text(date)
                            .font(.caption)
                            .foregroundColor(Color.oworiGray400)
                    }
                }
            }
            
        }
        .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
            ToolbarItem(placement: .principal) {
                Text("알림")
                    .font(
                        Font.custom("Pretendard", size: 20)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
            }
        }
    }
}


struct HomeNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNotificationView()
    }
}
