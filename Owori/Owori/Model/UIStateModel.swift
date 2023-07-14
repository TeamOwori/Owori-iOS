//
//  UIStateModel.swift
//  Owori
//
//  Created by 드즈 on 2023/07/15.
//
// 임시 Model
import Foundation

/*public*/ class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}
