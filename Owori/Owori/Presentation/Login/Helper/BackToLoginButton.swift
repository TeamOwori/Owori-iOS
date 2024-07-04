//
//  BackToLoginButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/24.
//

import SwiftUI

struct BackToLoginButton: View {
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("X")
        }
    }
}

struct BackToLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        BackToLoginButton()
    }
}
