//
//  Dishwasher.swift
//  Dishwashers
//
//  Created by Vasileios Loumanis on 18/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

enum DishwasherError: LocalizedError {
    case missingDishwasherId
    case missingTitle
    case missingPrice
}

class Dishwasher {

    private(set) var dishwasherId: String
    private(set) var title: String
    private(set) var price: Price
    private(set) var rawImage: String?

    init(dictionary: JSONDictionary) throws {

        guard let dishwasherId = dictionary[APIConstants.Dishwasher.dishwasherId] as? String else {
            throw DishwasherError.missingDishwasherId
        }
        guard let title = dictionary[APIConstants.Dishwasher.title] as? String else {
            throw DishwasherError.missingTitle
        }
        guard let priceJson = dictionary[APIConstants.Dishwasher.price] as? JSONDictionary,
              let price = try? Price(dictionary: priceJson) else {
            throw DishwasherError.missingPrice
        }
        self.dishwasherId = dishwasherId
        self.title = title
        self.price = price
        self.rawImage = dictionary[APIConstants.Dishwasher.rawImage] as? String
    }
}

extension Dishwasher {
    static func array(json: JSONDictionary) -> [Dishwasher]? {
        let jsonDishwashersArray =  json[APIConstants.Dishwasher.dishwashersArrayKey]
        guard let dishwashersArray = jsonDishwashersArray as? [JSONDictionary]  else { return nil }
        return dishwashersArray.compactMap { try? Dishwasher(dictionary: $0) }
    }
}
