//
//  MyPageProfilePhoto.swift
//  Owori
//
//  Created by 신예진 on 7/13/23.
//

import SwiftUI

struct MyPageProfilePhoto: View {
    var body: some View {
        VStack(spacing: 4) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 100, height: 100)
              .background(
                ZStack {
                    Image("ProfileImage")
                        .resizable()
                }
              )
              .cornerRadius(60)
        }
    }
}

struct MyPageProfilePhoto_Previews: PreviewProvider {
    static var previews: some View {
        MyPageProfilePhoto()
    }
}
