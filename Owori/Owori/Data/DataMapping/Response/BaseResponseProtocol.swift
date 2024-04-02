//
//  BaseResponseProtocol.swift
//  Owori
//
//  Created by kyungsoolee on 4/2/24.
//

import Foundation

import Foundation

protocol BaseResponseProtocol: Codable {
    var timestamp: String { get }
    var code: String { get }
    var message: String { get }
    associatedtype ResultType: Codable
    var result: ResultType { get }
}
