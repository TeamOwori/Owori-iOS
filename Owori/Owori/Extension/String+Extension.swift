//
//  String+Extension.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/04.
//

import SwiftUI

extension String {
    // MARK: FUNCTIONS
    /// - String으로 주어진 포멧에 맞게 현재 날짜를 출력해주는 함수
    func stringFromDate() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: now)
    }
}
