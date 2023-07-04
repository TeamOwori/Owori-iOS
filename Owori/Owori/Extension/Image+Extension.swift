//
//  Image+Extension.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/05.
//

import SwiftUI

extension Image {
    // MARK: FUNCTIONS
    /// - 보기 방식 선택에 따라 버튼 색깔을 변경해주는 함수.
    func applyColorInvert(_ isSet: Bool) -> some View {
        if isSet {
            return AnyView(self)
        } else {
            return AnyView(self.colorInvert())
        }
    }
}
