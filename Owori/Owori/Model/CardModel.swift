//
//  CardModel.swift
//  Owori
//
//  Created by 드즈 on 2023/07/15.
//
// 임시 Model
import Foundation

struct CardModel: Decodable, Hashable, Identifiable {
    var id: Int
    var name: String = ""
}
