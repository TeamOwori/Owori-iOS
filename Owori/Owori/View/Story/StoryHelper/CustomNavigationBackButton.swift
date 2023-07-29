//
//  CustomNavigationBackButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/26.
//

import SwiftUI

struct CustomNavigationBackButton: View {
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        
        
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image("BackArrow")
        }
        
    }
}

struct CustomNavigationBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBackButton()
    }
}
