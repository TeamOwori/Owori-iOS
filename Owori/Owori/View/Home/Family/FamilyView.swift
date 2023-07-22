//
//  FamilyView.swift
//  Owori
//
//  Created by 드즈 on 2023/07/06.
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.

import SwiftUI

struct FamilyView: View {
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var isDetailActive = false
    @State private var isDdayisOn = false // + CalendarView에서 디데이 기능 선택 여부
    
    // 임시 - 가족사진 정보 변수
    var familyPhotos = [
        Photo.PhotoInfo(id: "1", name: "TestImage1"),
        Photo.PhotoInfo(id: "2", name: "TestImage2"),
        Photo.PhotoInfo(id: "3", name: "TestImage3"),
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.oworiMainColor
                if familyPhotos.isEmpty {
                    FamilyInitialPhoto()
                } else {
                    ForEach(0..<familyPhotos.count, id: \.self) { index in
                        Image("\(familyPhotos[index].name)")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.76, height: UIScreen.main.bounds.height * 0.21)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.06), radius: 6, x: -4, y: 5)
                            .shadow(color: .black.opacity(0.1), radius: 7, x: 4, y: 2)
                            .offset(x: CGFloat(index - currentIndex) * 325 /* 300 */ + dragOffset, y: 0)
                            .onTapGesture {
                                isDetailActive = true
                            }
                    }
//                    NavigationLink(isActive: $isDetailActive) {
//                        RemainPhotoView()
//                    } label: {
//                        EmptyView()
//                    }
                }
            }
            .gesture(
                DragGesture()
                    .onEnded{ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(familyPhotos.count - 1, currentIndex + 1)
                            }
                        }
                    }
            )
        }
        .frame(height: UIScreen.main.bounds.height * 0.21)
    }
}

struct FamilyView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyView()
    }
}
