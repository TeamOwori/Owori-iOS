//
//  BackToFamilyLinkViewButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/27.
//

import SwiftUI

struct BackToFamilyLinkViewButton: View {
    @Binding var isCreateCodeViewVisible: Bool
    @Binding var isReceiveCodeViewVisible: Bool
    
    var body: some View {
        Button {
            isCreateCodeViewVisible = false
            isReceiveCodeViewVisible = false
        } label: {
            Text("X")
        }
        
    }
}

struct BackToFamilyLinkViewButton_Previews: PreviewProvider {
    static var previews: some View {
        BackToFamilyLinkViewButton(isCreateCodeViewVisible: .constant(false), isReceiveCodeViewVisible: .constant(false))
    }
}
