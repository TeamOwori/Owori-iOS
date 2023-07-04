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
                Image(systemName: "square.grid.2x2")
                    .foregroundColor(changingColor(buttonSet))
            }
            Button {
                buttonSet = false
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundColor(changingColor(!buttonSet))
            }
        }
    }
}

// MARK: FUNCTIONS
/// - 보기 방식 선택에 따라 버튼 색깔을 변경해주는 함수.
func changingColor(_ isSet: Bool) -> Color {
    if isSet {
        return .black
    } else {
        return .gray
    }
}


// MARK: PREVIEWS
struct AlbumListButton_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListButton(buttonSet: .constant(true))
    }
}
