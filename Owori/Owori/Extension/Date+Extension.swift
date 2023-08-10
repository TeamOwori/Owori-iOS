//
//  Date+Extension.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/10.
//

import SwiftUI

extension Date {
    func formatDateToString(format: String) -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd"
        return dataFormatter.string(from: self)
    }
}
