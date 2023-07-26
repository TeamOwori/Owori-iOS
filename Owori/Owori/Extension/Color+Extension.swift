//
//  Color+Extension.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/07/06.
//

import SwiftUI

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

extension Color {
    static let oworiGray100 = Color(hex: "#E5E5E5")
    static let oworiGray200 = Color(hex: "#E9E9E9")
    static let oworiGray300 = Color(hex: "#C6C6C6")
    static let oworiGray400 = Color(hex: "#909090")
    static let oworiGray500 = Color(hex: "#787878")
    static let oworiGray600 = Color(hex: "#626262")
    static let oworiGray700 = Color(hex: "#464646")
    static let oworiMain = Color(hex: "#FFEEB2")
    static let oworiOrange = Color(hex: "#FA7B53")
    static let oworiDarkGray = Color(hex: "#212121")
}
