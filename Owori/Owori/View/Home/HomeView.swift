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
                .ignoresSafeArea(.all)
            VStack(alignment: .center, spacing: 30) {
                ProfileView()
                DDayView()
                    .padding(EdgeInsets(top: 30, leading: 50, bottom: 20, trailing: 0))
                FamilyView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
