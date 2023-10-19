//
//  FamilyInitialPhoto.swift
//  Owori
//
//  Created by 희 on 2023/08/03
//

import SwiftUI

struct FamilyInitialPhoto: View {
    @State private var isAddFamilyPhotoActive = false
    
    var body: some View {
        ZStack{
            Color.oworiMain.ignoresSafeArea()
            Button {
                isAddFamilyPhotoActive = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(Color.oworiGray300, style: StrokeStyle(lineWidth: 1, dash: [5, 5])))
                    VStack(spacing: 25) {
                        Text("사진 자유롭게 올리는 공간이에요!\n가족사진을 올려보는건 어떨까요?")
                            .foregroundColor(.gray)
                        Image(systemName: "plus")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $isAddFamilyPhotoActive) {
                AddFamilyPhoto()
            }
        }
    }
}

struct FamilyInitialPhoto_Previews: PreviewProvider {
    static var previews: some View {
        FamilyInitialPhoto()
    }
}

