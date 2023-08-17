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
        dataFormatter.dateFormat = format
        return dataFormatter.string(from: self)
    }
    
//    func diff(numDays: Int) -> Date {
//        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
//    }
//
//    var startOfDay: Date {
//        Calendar.current.startOfDay(for: self)
//    }

}

////  Created by 신예진 on 8/11/23.
////
//
//import Foundation
//
//extension Date {
//    func diff(numDays: Int) -> Date {
//        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
//    }
//
//    var startOfDay: Date {
//        Calendar.current.startOfDay(for: self)
//>>>>>>> Stashed changes
//    }
//}
