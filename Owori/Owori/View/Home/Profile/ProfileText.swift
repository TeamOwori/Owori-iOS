//
//  ProfileText.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct ProfileText: View {
    // 사용자 닉네임
    @Binding var nickName: String
    
    var body: some View {
        Text(nickName)
    }
}

struct ProfileText_Previews: PreviewProvider {
    static var previews: some View {
        ProfileText(nickName: .constant("name"))
    }
}
