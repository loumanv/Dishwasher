//
//  Factory.swift
//  DishwashersTests
//
//  Created by Vasileios Loumanis on 18/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

@testable import Dishwashers

class Factory {

    static func createPrice() -> Price {

        let dictionary: JSONDictionary = [
            "was": "444.50",
            "then1": "431.50",
            "then2": "421.00",
            "now": "349.00",
            "uom": "test",
            "currency": "GBP"
        ]
        return try! Price(dictionary: dictionary)
    }
}
