//
//  SortMenu.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/06.
//

import SwiftUI

struct SortMenu: View {
    private var sortingMethods: [String] = ["최신순"/*, "Text Text", "."*/]
    @State private var seletedMethod: String = "최신순"
    
    var body: some View {
        Menu {
            ForEach(sortingMethods, id: \.self) { method in
                Button {
                    seletedMethod = method
                } label: {
                    Text(method)
                }
            }
        } label: {
            HStack {
                Text(seletedMethod)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                Image("ArrowDown")
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .foregroundColor(.gray)
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 1))
    }
}

struct SortMenu_Previews: PreviewProvider {
    static var previews: some View {
        SortMenu()
    }
}
