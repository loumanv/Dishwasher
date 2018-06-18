//
//  Factory.swift
//  DishwashersTests
//
//  Created by Vasileios Loumanis on 18/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation
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

    static func createDishwasher() -> Dishwasher {

        let dictionary: JSONDictionary = [
            "productId": "3215462",
            "title": "Bosch SMS25AW00G Freestanding Dishwasher, White",
            "price": [
                "was": "",
                "then1": "",
                "then2": "",
                "now": "349.00",
                "uom": "",
                "currency": "GBP"
            ],
            "image": "//johnlewis.scene7.com/is/image/JohnLewis/236888507?"
        ]
        return try! Dishwasher(dictionary: dictionary)
    }

    static func createDishwashers() -> [Dishwasher] {
        let fileURL = Bundle(for: Dishwasher.self).url(forResource: "dishwashers", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! JSONDictionary
        return Dishwasher.array(json: dictionary)!
    }
}
