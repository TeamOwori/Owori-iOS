//
//  FamilyCarousel.swift
//  Owori
//
//  Created by 드즈 on 2023/07/14.
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.

import SwiftUI

struct FamilyCarousel: View {
    @EnvironmentObject var UIState: UIStateModel
    
    let spacing: CGFloat = 20
    let widthOfHiddenCards: CGFloat = 32
    let cardHeight: CGFloat = 180
    
    let images = [
        CardModel(id: 0, name: "TestImage1"),
        CardModel(id: 1, name: "TestImage2"),
        CardModel(id: 2, name: "TestImage3"),
        CardModel(id: 3, name: "TestImage4")
    ]
    
    var body: some View {
        /*return*/ Canvas {
            Carousel(
                numberOfItems: CGFloat(images.count),
                spacing: spacing,
                widthOfHiddenCards: widthOfHiddenCards
            ) {
                ForEach(images, id: \.self.id) { item in
                    FamilyPhotoItem(
                        _id: Int(item.id),
                        spacing: spacing,
                        widthOfHiddenCards: widthOfHiddenCards,
                        cardHeight: cardHeight
                    ) {
                        Image("\(item.name)")
                            .resizable()
                    }
                    .cornerRadius(12)
                    .transition(AnyTransition.slide)
                    //.animation(.spring())
                }
            }
        }
    }
}

struct FamilyCarousel_Previews: PreviewProvider {
    static var previews: some View {
        FamilyCarousel()
    }
}
