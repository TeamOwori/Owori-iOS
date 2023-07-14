//
//  FamilyView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.

import SwiftUI

struct FamilyView: View {
    //@StateObject var cardModel = CardModel()
    @StateObject var carouselViewModel = CarouselViewModel() // 임시 ViewModel
    
    var body: some View {
        ZStack {
            //Text("Active card is \(carouselViewModel.activeCard)")
            FamilyCarousel()
                .environmentObject(carouselViewModel.stateModel) // 임시 ViewModel
        }
        .frame(height: 135)
    }
}

struct FamilyView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyView()
    }
}
