//
//  ProfileImage.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct ProfileImage: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink {
                            SelectEmotionBadge()
                        } label: {
                            ZStack {
                                Color.white
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.16), radius: 8, x: 4, y: 4)
                                    .shadow(color: .black.opacity(0.04), radius: 4, x: 4, y: -2)
                                ProfileEmotionBadge() // 오늘의 한마디에서는 제거되어야 함
                            }
                        }
                    }
                }
            }
            .frame(width: 60, height: 60)
            .background(
                Image("TestImage2")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle()))
        }
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage()
    }
}
