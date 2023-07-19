//
//  AppleLoginTestViewModel.swift
//  Owori
//
//  Created by 신예진 on 7/20/23.
//

import SwiftUI
import AuthenticationServices

class AppleLoginTestViewModel: ObservableObject {
    
    @Published var socialToken: Token = Token()
    

    func appleLoginButton() -> some View {
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Apple Login Successful")
                    switch authResults.credential{
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        // 계정 정보 가져오기
                        let UserIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                        let email = appleIDCredential.email
                        let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        
                        let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                        
                        DispatchQueue.main.async { [weak self] in
                            
                            self?.socialToken = Token(authProvider: "APPLE", accessToken: IdentityToken!, refreshToken: IdentityToken!)
                            
                            print("UserIdentifier: \(UserIdentifier)")
                            print("IdentityToken: \(IdentityToken)")
                            print("AuthorizationCode: \(AuthorizationCode)")
                        }
                        
                    default:
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("error")
                }
            }
        )
        .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
        .cornerRadius(5)
    }
    
    
    
}
