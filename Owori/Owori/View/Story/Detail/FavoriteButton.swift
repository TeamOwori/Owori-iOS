//
//  FavoriteButton.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/10.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    var body: some View {
        Button {
            isFavorite.toggle()
        } label: {
            VStack {
                Image(isFavorite ? "FavoriteFill" : "FavoriteUnfill")
            }
        }
        
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isFavorite: .constant(true))
    }
}
