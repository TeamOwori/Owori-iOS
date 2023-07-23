//
//  BackToLoginButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/24.
//

import SwiftUI

struct BackToLoginButton: View {
    @Binding var currentIndex: Int
    @EnvironmentObject var loginViewModel: LoginViewModel
    var body: some View {
        
        if 1 < currentIndex && currentIndex <= 5 {
            Button {
                // 왜 그런지 모르겠는데 더블클릭 하면 뷰가 한박자 늦게 반영될 때가 있어서
                // 0보다 작아지면 0으로 처리하도록 해놨습니다.
                if currentIndex < 1 {
                    currentIndex = 1
                } else {
                    loginViewModel.isLoggedIn = false
                }
            } label: {
                Text("X")
            }
        }
    }
}

struct BackToLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        BackToLoginButton(currentIndex: .constant(1))
            .environmentObject(LoginViewModel())
    }
}
