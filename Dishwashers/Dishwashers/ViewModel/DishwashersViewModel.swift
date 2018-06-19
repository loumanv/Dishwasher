//
//  DishwashersViewModel.swift
//  Dishwashers
//
//  Created by Vasileios Loumanis on 19/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

class DishwashersViewModel {

    private(set) var dishwashers: [Dishwasher]
    private let curencySymbols = ["GBP": "£"]

    init(dishwashers: [Dishwasher]) {
        self.dishwashers = dishwashers
    }

    func title(for row: Int) -> String {
        return dishwashers[row].title
    }

    func price(for row: Int) -> String {
        return "\(curencySymbol(code: dishwashers[row].price.currency))\(dishwashers[row].price.now)"
    }

    func image(for row: Int) -> URL? {
        guard let rawImage = dishwashers[row].rawImage,
            let imageURL = URL(string: rawImage) else { return nil }
        return imageURL
    }

    private func curencySymbol(code: String) -> String {

        guard curencySymbols.keys.contains(code), let symbol = curencySymbols[code] else { return ""}
        return symbol
    }
}
