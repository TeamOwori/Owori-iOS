//
//  MyPageProfilePhoto.swift
//  Owori
//
//  Created by 신예진 on 7/13/23.
//

import SwiftUI
import PhotosUI

struct MyPageProfilePhoto: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack(spacing: 4) {
            
            AsyncImage(url: URL(string: userViewModel.user.member_profile?.profile_image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
            } placeholder: {
                Image("DefaultImage")
            }
            
            
//            Button{
//                //프로필 사진 변경하게 앨범으로 들어가게끔 해야함??!
//            } label: {
//                Rectangle()
//                  .foregroundColor(.clear)
//                  .frame(width: 100, height: 100)
//                  .background(
//                    ZStack {
//                        Image("ProfileImage")
//                            .resizable()
//                    }
//                  )
//                  .cornerRadius(60)
//
//            }
        
        }
    }
}

struct MyPageProfilePhoto_Previews: PreviewProvider {
    static var previews: some View {
        MyPageProfilePhoto()
    }
}
