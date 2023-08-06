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
    var memberProfile: Family.MemberProfile
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var familyViewModel: FamilyViewModel
    
    var body: some View {
        //        NavigationStack {
        VStack(spacing: 4) {
            ZStack {
                ProfileImage(profileImage: memberProfile.profile_image ?? "DefaultImage")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if memberProfile.emotional_badge != "NONE" {
                            ZStack {
                                Color.white
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.16), radius: 8, x: 4, y: 4)
                                    .shadow(color: .black.opacity(0.04), radius: 4, x: 4, y: -2)
                                Button {
                                    //                                    SelectEmotionBadge()
                                } label: {
                                    ProfileEmotionBadge(emotionalBadge: memberProfile.emotional_badge ?? "NONE")
                                }
                            }
                        }
                    }
                }
                .frame(width: 64, height: 64)
            }
            ProfileText(nickname: memberProfile.nickname ?? "nickname")
                .padding(0)
        }
        .onAppear {
            print(memberProfile)
        }
    }
}

struct ProfileImageWithBadge_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageWithBadge(memberProfile: Family.MemberProfile())
    }
}
