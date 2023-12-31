//
//  MyPageProfileInfo.swift
//  Owori
//
//  Created by 신예진 on 7/13/23.
//

import SwiftUI

//MARK: API 받아올 때 수정해야하는 부분
struct MyPageProfileStyle: Identifiable {
    let id: UUID
    let profileImage: String
    let nickname: String
    let birth: String
    let myColor: String
}

struct MyPageProfileInfo: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            HStack(alignment: .center, spacing: 20) {
                Text("닉네임\t")
                    .font(Font.custom("Pretendard", size: 14)
                        .weight(.medium))
                    .foregroundColor(Color.oworiGray500)
                Text("\(userViewModel.user.member_profile?.nickname ?? "닉네임이 설정되지 않았습니다")")
                    .font(Font.custom("Pretendard", size: 16)
                        .bold())
                    .foregroundColor(Color.oworiGray700)
            }
            
            HStack(alignment: .center, spacing: 16) {
                Text("마이 컬러\t")
                    .font(
                        Font.custom("Pretendard", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.oworiGray500)
                Circle()
                    .foregroundColor(Color.colorFromString(userViewModel.user.member_profile?.color ?? "None"))
                    .frame(width: 24, height: 24)
            }   
        }
    }
}

struct MyPageProfileInfo_Previews: PreviewProvider {
    static var previews: some View {
        MyPageProfileInfo()
            .environmentObject(UserViewModel())
    }
}
