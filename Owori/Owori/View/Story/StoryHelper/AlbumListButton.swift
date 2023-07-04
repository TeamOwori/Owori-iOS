//
//  AlbumListButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

struct AlbumListButton: View {
    // MARK: PROPERTIES
    /// - true : 앨범형 / false : 리스트형
    @Binding var buttonSet: Bool
    
    
    // MARK: BODY
    var body: some View {
        HStack {
            Button {
                buttonSet = true
            } label: {
                Image("Album").applyColorInvert(buttonSet)
            }
            Button {
                buttonSet = false
            } label: {
                Image("List").applyColorInvert(!buttonSet)
            }
        }
    }
}


// MARK: PREVIEWS
struct AlbumListButton_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListButton(buttonSet: .constant(true))
    }
}
