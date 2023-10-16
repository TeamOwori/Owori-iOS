//
//  AlbumListButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct AlbumListButton: View {
    @Binding var buttonSet: Bool
    
    var body: some View {
        HStack {
            Button {
                buttonSet = true
            } label: {
                Image("List").applyColorInvert(buttonSet)
            }
            Button {
                buttonSet = false
            } label: {
                Image("Album").applyColorInvert(!buttonSet)
            }
        }
    }
}

struct AlbumListButton_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListButton(buttonSet: .constant(true))
    }
}
