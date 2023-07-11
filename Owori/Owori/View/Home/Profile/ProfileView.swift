//
//  ProfileView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct ProfileView: View {
    /// - [임시] 가족 구성원 수 데이터
    /// - 실제 데이터 들어오면 없어질 예정
    private var familyCount: Int = 4
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(0..<familyCount) { _ in
                ProfilePhoto()
            }
        }
        //.background(Color(.green))
        .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
        .frame(width: 375, height: 82, alignment: .leading)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
