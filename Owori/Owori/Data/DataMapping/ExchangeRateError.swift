//
//  ExchangeRateError.swift
//  Owori
//
//  Created by kyungsoolee on 3/6/24.
//

import Foundation

enum ExchangeRateError: Error {
    case badRequest
    case decodeFailed
    case cannotCreateURL
}
