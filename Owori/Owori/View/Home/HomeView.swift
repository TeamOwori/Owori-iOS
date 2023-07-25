//
//  HomeView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.oworiMainColor
                .ignoresSafeArea()
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 30) {
                    ProfileView()
                    DDayView()
                        .padding(.leading, 50) // .padding(EdgeInsets(top: 30, leading: 50, bottom: 20, trailing: 0))
                    FamilyView()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
