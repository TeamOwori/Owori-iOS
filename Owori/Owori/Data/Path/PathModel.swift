//
//  PathModel.swift
//  Owori
//
//  Created by kyungsoolee on 7/5/24.
//

import Foundation

protocol PathModel {
    associatedtype PathType: Hashable
    var paths: [PathType] { get }
}
