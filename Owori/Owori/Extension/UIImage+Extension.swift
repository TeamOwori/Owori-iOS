//
//  UIImage+Extension.swift
//  Owori
//
//  Created by Kyungsoo Lee on 2023/08/10.
//

import SwiftUI

//extension UIImage {
//    //안됨...
//    var imageFormat: String? {
//        guard let data = self.pngData() else { return nil }
//        var format: String?
//        var buffer = [UInt8](repeating: 0, count: 1)
//        data.copyBytes(to: &buffer, count: 1)
//
//        switch buffer[0] {
//            case 0x89:
//                format = "png"
//            case 0xFF:
//                format = "jpeg"
//            default:
//                break
//        }
//
//        return format
//    }
//}
