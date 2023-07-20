//
//  FamilyInitialPhoto.swift
//  Owori
//
//  Created by 드즈 on 2023/07/20.
//

import SwiftUI

struct FamilyInitialPhoto: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                    AddFamilyPhoto()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color.gray/*300*/, style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                            )
                        VStack(spacing: 25) {
                            Text("사진 자유롭게 올리는 공간이에요!\n가족사진을 올려보는건 어떨까요?")
//                                .font(
//                                    Font.custom("Pretendard", size: 14)
//                                )
                                .foregroundColor(.gray)
                                //.padding(25)
                            Image(systemName: "plus")
                                .foregroundColor(.gray)
                        }
                        .frame(width: 260, height: 140)
                    }
            }
        }
    }
}

struct FamilyInitialPhoto_Previews: PreviewProvider {
    static var previews: some View {
        FamilyInitialPhoto()
    }
}
