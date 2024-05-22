//
//  DataError.swift
//  EffectiveMobile
//
//  Created by Диана Мишкова on 6.05.24.
//

import Foundation


enum DataError: Error {
    case networkingError(String)
    case coreDataError(String)
}
