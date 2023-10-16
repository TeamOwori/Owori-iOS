//
//  FamilyView.swift
//  Owori
//
//  Created by 희 on 2023/07/06.
//  

import SwiftUI

struct FamilyView: View {
    @State private var family: Family = Family()
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.oworiMain
                    .ignoresSafeArea()
                ForEach(0..<(family.family_images?.count ?? 0), id: \.self) { index in
                    Image(family.family_images?[index] ?? "")
                        .resizable()
                        .frame(width: 300, height: 180)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.06), radius: 6, x: -4, y: 5)
                        .shadow(color: .black.opacity(0.1), radius: 7, x: 4, y: 2)
                        .offset(x: CGFloat(index - currentIndex) * 325 /* 300 */ + dragOffset, y: 0)
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
                                currentIndex = min((family.family_images?.count ?? 0) - 1, currentIndex + 1)
                            }
                        }
                    }
            )
        }
        .frame(height: 200)
    }
}

struct FamilyView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyView()
    }
}
