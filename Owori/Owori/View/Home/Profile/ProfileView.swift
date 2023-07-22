//
//  ProfileView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            HStack(spacing: 16) {
                ForEach(1...3, id: \.self) { _ in
                    ProfileImageWithBadge()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .frame(width: UIScreen.main.bounds.width * 0.95, alignment: .leading)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
