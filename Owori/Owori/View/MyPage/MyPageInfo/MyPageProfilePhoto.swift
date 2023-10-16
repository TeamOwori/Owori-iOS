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
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(12)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            } placeholder: {
                Image("DefaultImage")
            }
        }
    }
}

struct MyPageProfilePhoto_Previews: PreviewProvider {
    static var previews: some View {
        MyPageProfilePhoto()
    }
}
