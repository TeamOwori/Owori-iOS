//
//  BackCancel.swift
//  Owori
//
//  Created by 드즈 on 2023/07/25.
//

import SwiftUI

struct BackCancel: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image("Close")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }
}

struct BackCancel_Previews: PreviewProvider {
    static var previews: some View {
        BackCancel()
    }
}
