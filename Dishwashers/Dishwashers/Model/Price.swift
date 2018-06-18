//
//  Price.swift
//  Dishwashers
//
//  Created by Vasileios Loumanis on 18/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

enum PriceError: LocalizedError {
    case missingNowPrice
    case missingCurrency
}

class Price {

    private(set) var was: String?
    private(set) var then1: String?
    private(set) var then2: String?
    private(set) var now: String
    private(set) var uom: String?
    private(set) var currency: String

    init(dictionary: JSONDictionary) throws {

        guard let now = dictionary[APIConstants.Price.now] as? String else { throw PriceError.missingNowPrice }
        guard let currency = dictionary[APIConstants.Price.currency] as? String else {
            throw PriceError.missingCurrency
        }
        self.now = now
        self.currency = currency
        self.was = dictionary[APIConstants.Price.was] as? String
        self.then1 = dictionary[APIConstants.Price.then1] as? String
        self.then2 = dictionary[APIConstants.Price.then2] as? String
        self.uom = dictionary[APIConstants.Price.uom] as? String
    }
}
