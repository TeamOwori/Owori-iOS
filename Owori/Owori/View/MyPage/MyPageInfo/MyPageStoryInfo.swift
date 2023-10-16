//
//  MyPageStoryInfo.swift
//  Owori
//
//  Created by 신예진 on 7/13/23.
//

import SwiftUI

struct MyPageStoryStyle: Identifiable {
    let id: UUID
    let writtenStory: Int
    let favoriteStory: Int
    let LetterBox: Int
}

struct MyPageStoryInfo: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .center, spacing: 10) {
                Text("\(userViewModel.user.member_profile?.story_count ?? 0)")
                    .font(
                        Font.custom("Pretendard", size: 18)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color.oworiOrange)
                Text("작성한 이야기")
                    .font(Font.custom("Pretendard", size: 12))
                    .kerning(0.18)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.oworiGray700)
            }
            .frame(width: 82, alignment: .top)
            .background(Color.oworiGray100)
            VStack(alignment: .center, spacing: 10) {
                Text("\(userViewModel.user.member_profile?.heart_count ?? 0)")
                    .font(
                        Font.custom("Pretendard", size: 18)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color.oworiOrange)
                
                Text("좋아하는 이야기")
                    .font(Font.custom("Pretendard", size: 12))
                    .kerning(0.18)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.oworiGray700)
            }
            .frame(width: 82, alignment: .top)
            .background(Color.oworiGray100)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 16)
        .background(Color.oworiGray100)
        .cornerRadius(12)
    }
}

struct MyPageStoryInfo_Previews: PreviewProvider {
    static var previews: some View {
        MyPageStoryInfo()
    }
}
