//
//  ProfileView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct ProfileView: View {
    //@Binding var profiles: [Family.MemberProfile] // 임시 - 프로필 정보
//    @State private var profiles: [Family.MemberProfile] = [
//        Family.MemberProfile(id: "1", nick_name: "고삼이", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue"),
//        Family.MemberProfile(id: "2", nick_name: "끼룩꾹꾸끼룩꾸", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue"),
//        Family.MemberProfile(id: "3", nick_name: "쥐렁이", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue"),
//        Family.MemberProfile(id: "4", nick_name: "여왕님", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue"),
//        Family.MemberProfile(id: "1", nick_name: "고삼이", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue"),
//        Family.MemberProfile(id: "2", nick_name: "끼룩꾹꾸끼룩꾸", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue"),
//        Family.MemberProfile(id: "3", nick_name: "쥐렁이", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue"),
//        Family.MemberProfile(id: "4", nick_name: "여왕님", profile_image: "DefaultImage", emotional_badge: "squinting-face-with-tongue")
//    ]
    
    @EnvironmentObject var familyViewModel: FamilyViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: UIScreen.main.bounds.width * 0.04) {
                // 옵셔널 바인딩 수정해야 함
                ForEach(familyViewModel.family.member_profiles ?? [], id: \.self) { item in
                    ProfileImageWithBadge(memberProfile: item)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width * 0.05, bottom: 0, trailing: UIScreen.main.bounds.width * 0.05))
        .frame(height: 80) //.frame(height: UIScreen.main.bounds.height * 0.125)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
