//
//  ContentText.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/12.
//

import SwiftUI

struct ContentText: View {
    // MARK: PROPERTIES
    /// - [임시] 좋아요 수 데이터
    /// - 실제 이미지가 들어오면 없어질 예정
    var numberOfFavorite: Int = 4
    
    /// - [임시] 댓글 수 데이터
    /// - 실제 이미지가 들어오면 없어질 예정
    var numberOfcomment: Int = 2
    
    var contentText: String = "종강하면 동해바다로 가족여행 가자고 한게 엊그제같았는데...3박 4일 동해여행 너무 재밌었어!! 날씨도 너무 좋았고 특히 갈치조림이 대박👍🏻 ㄹㅇ 맛집 인정... 2일차 점심 때 대림공원 안에서 피크닉한게 가장 기억에 남았던거 같아! 엄마가 만들어 준 샌드위치는 세상에서 젤 맛있어 이거 팔면 대박날듯 ㅋㅋㅋ"
    
    var body: some View {
        VStack {
            // Text font 스타일 Extension으로 빼서 정리하기
            Text(contentText)
                .font(.system(size: 16, weight: .medium))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            HStack {
                Text("좋아요 \(numberOfFavorite)")
                    .foregroundColor(Color.oworiGray400)
                    .font(.system(size: 12, weight: .regular))
                Text("댓글 \(numberOfcomment)")
                    .foregroundColor(Color.oworiGray400)
                    .font(.system(size: 12, weight: .regular))
                Spacer()
                Button {
                    
                } label: {
                    Text("삭제하기")
                        .foregroundColor(Color.oworiGray400)
                        .font(.system(size: 12, weight: .regular))
                }
                Divider()
                    .frame(width: 1, height: 10)
                    .overlay(Color.oworiGray200)
                Button {
                    
                } label: {
                    Text("수정하기")
                        .foregroundColor(Color.oworiGray400)
                        .font(.system(size: 12, weight: .regular))
                }
            }
        }
    }
}

struct ContentText_Previews: PreviewProvider {
    static var previews: some View {
        ContentText()
    }
}
