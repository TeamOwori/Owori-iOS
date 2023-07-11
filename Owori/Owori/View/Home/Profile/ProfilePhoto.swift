//
//  ProfileInfo.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct ProfilePhoto: View {
    var body: some View {
        VStack(spacing: 4) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 60, height: 60)
              .background(
                ZStack {
                    Image("DefaultImage")
                        .resizable()
                    Image("image")
                        .resizable()
                }
              )
              .cornerRadius(60)
//              .shadow(color: .black.opacity(0.16), radius: 8, x: 4, y: 4)
//              .shadow(color: .black.opacity(0.04), radius: 4, x: 4, y: -2)
//              .padding(4)
            ProfileText(nickName: .constant("name"))
        }
    }
}

struct ProfilePhoto_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhoto()
    }
}
