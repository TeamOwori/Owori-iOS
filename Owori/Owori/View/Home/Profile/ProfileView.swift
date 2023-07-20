//
//  ProfileView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct ProfileView: View {
    // 임시 가족 구성원 수 정보
    private var familyCount: Int = 4
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(0..<familyCount, id: \.self) { _ in
                ProfileItem()
            }
        }
//        .background(Color(.green)) // for test
        .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
        .frame(width: 375, height: 82, alignment: .leading)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
