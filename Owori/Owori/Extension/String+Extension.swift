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
    
    func toDate(dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.date(from: self)
    }
    
    func convertToISODateFormat() -> String {
            let dateFormatterInput = DateFormatter()
            dateFormatterInput.dateFormat = "yyyyMMdd"

            if let date = dateFormatterInput.date(from: self) {
                let dateFormatterOutput = DateFormatter()
                dateFormatterOutput.dateFormat = "yyyy-MM-dd"
                return dateFormatterOutput.string(from: date)
            }
        return "0000-00-00"
        }
}
