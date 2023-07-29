//
//  ProfileImageWithBadge.swift
//  Owori
//
//  Created by 드즈 on 2023/07/23.
//

import SwiftUI

struct ProfileImageWithBadge: View {
    //@Binding var profiles: [Family.MemberProfile] // 임시 - 프로필 정보
    
    @State private var isEmotion: Bool = true // false
    
    var body: some View {
//        NavigationStack {
            VStack(spacing: 4) {
                ZStack {
                    ProfileImage()
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            if isEmotion {
                                ZStack {
                                    Color.white
                                        .frame(width: 24, height: 24)
                                        .clipShape(Circle())
                                        .shadow(color: .black.opacity(0.16), radius: 8, x: 4, y: 4)
                                        .shadow(color: .black.opacity(0.04), radius: 4, x: 4, y: -2)
                                    Button {
                                        //                                    SelectEmotionBadge()
                                    } label: {
                                        ProfileEmotionBadge()
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: 64, height: 64)
                }
                
//                VStack {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        ZStack {
//                            Color.white
//                                .frame(width: 24, height: 24)
//                                .clipShape(Circle())
//                                .shadow(color: .black.opacity(0.16), radius: 8, x: 4, y: 4)
//                                .shadow(color: .black.opacity(0.04), radius: 4, x: 4, y: -2)
//                            NavigationLink {
//                                SelectEmotionBadge()
//                            } label: {
//                                Image("squinting-face-with-tongue")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 18, height: 18)
//                                    .clipped()
//                            }
//                        }
//                    }
//                }
//                .frame(width: 64, height: 64)
//                .background(ProfileImage())
                
                ProfileText()
                    .padding(0)
            }
//        }
    }
}

struct ProfileImageWithBadge_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageWithBadge()
    }
}
