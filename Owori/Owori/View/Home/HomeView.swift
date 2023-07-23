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
            VStack(spacing: 40) {
                ProfileView()
                DDayView()
                FamilyView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
