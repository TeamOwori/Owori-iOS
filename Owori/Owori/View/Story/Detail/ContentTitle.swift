//
//  ContentTitle.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/12.
//

import SwiftUI

struct ContentTitle: View {
    @Binding var isFavorite: Bool
    var titleText: String = "기다리고 기다리던 하루"
    
    /// - [임시] 작성자 데이터
    /// - 실제 이미지가 들어오면 없어질 예정
    var author: String = "쥐렁이"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("yyyy년 MM월 dd일".stringFromDate() + " - " + "yyyy년 MM월 dd일".stringFromDate())
                    .foregroundColor(Color.oworiGray600)
                    .font(.system(size: 12, weight: .regular))
                Spacer()
                FavoriteButton(isFavorite: $isFavorite)
            }
            HStack(alignment: .bottom, spacing: 16) {
                Text(titleText)
                    .foregroundColor(Color.oworiGray700)
                    .font(.system(size: 20, weight: .bold))
                Text("by \(author)")
                    .foregroundColor(Color.oworiGray700)
                    .font(.system(size: 12, weight: .regular))
            }
        }
    }
}

struct ContentTitle_Previews: PreviewProvider {
    static var previews: some View {
        ContentTitle(isFavorite: .constant(true))
    }
}
