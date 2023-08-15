//
//  ProfileView.swift
//  Owori
//
//  Created by 희 on 2023/07/06.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var familyViewModel: FamilyViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var emotionalBadgeViewIsActive: Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: UIScreen.main.bounds.width * 0.04) {
                // 옵셔널 바인딩 수정해야 함
                ForEach(familyViewModel.family.member_profiles ?? [], id: \.self) { item in
                    Button {
                        if item == familyViewModel.family.member_profiles?.first {
                            emotionalBadgeViewIsActive = true
                        }
                    } label: {
                        ProfileImageWithBadge(memberProfile: item)
                    }
                }
            }
        }
//        .navigationDestination(isPresented: $emotionalBadgeViewIsActive) {
//                SelectEmotionBadge(emotionalBadgeViewIsActive: $emotionalBadgeViewIsActive)
//        }
        .padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width * 0.05, bottom: 0, trailing: UIScreen.main.bounds.width * 0.05))
        .frame(height: 80) //.frame(height: UIScreen.main.bounds.height * 0.125)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(emotionalBadgeViewIsActive: .constant(false))
            .environmentObject(UserViewModel())
            .environmentObject(FamilyViewModel())
    }
}
