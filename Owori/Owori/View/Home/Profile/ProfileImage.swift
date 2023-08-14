//
//  ProfileImage.swift
//  Owori
//
//  Created by 희 on 2023/07/23.
//

import SwiftUI

struct ProfileImage: View {
    var profileImage: String
    
    var body: some View {
        
        AsyncImage(url: URL(string: profileImage)) { image in
            image
                .resizable()
        } placeholder: {
            Image("DefaultImage")
        }
        .frame(width: 60, height: 60)
        .clipShape(Circle())
        
        
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(profileImage: "DefaultImage")
    }
}
