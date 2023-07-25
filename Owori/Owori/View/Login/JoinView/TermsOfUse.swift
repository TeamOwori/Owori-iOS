//
//  TermsOfUse.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/22.
//

import SwiftUI

struct TermsOfUse: View {
    @Binding var currentIndex: Int
    @Binding var nickname: String
    @Binding var birthDateText: String
    @Binding var previousBirthDateText: String
    @Binding var familyName: String
    @Binding var inviteCode: String
    
    @State private var isSuccessSignUp = false
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            NumberIndicator(currentIndex: $currentIndex)
                .padding(.top, 60)
            VStack(alignment: .leading) {
                Text("오월이가 처음이시죠?\n필수약관에 동의해주세요")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                
                NavigationLink (value: 6) {
                    Button {
                        currentIndex = 0
                        isSuccessSignUp = true
                    } label: {
                        Text("임시 확인")
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    BackToLoginButton(currentIndex: $currentIndex)
                }
                .navigationDestination(isPresented: $isSuccessSignUp) {
                    HomeView()
                    
                }
            }
            .onAppear {
                currentIndex = 5
            }
        }
    }
}

struct TermsOfUse_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfUse(currentIndex: .constant(3), nickname: .constant(""), birthDateText: .constant(""), previousBirthDateText: .constant(""), familyName: .constant(""), inviteCode: .constant(""))
    }
}
