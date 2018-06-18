//
//  DishwasherTests.swift
//  DishwashersTests
//
//  Created by Vasileios Loumanis on 18/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Dishwashers

class DishwasherTests: XCTestCase {

    func testDishwasherInitializationSucceeds() {
        let dishwasher = Factory.createDishwasher()
        XCTAssertNotNil(dishwasher)
    }

    func testThrowsErrorWhenIdIsMissing() {
        let dictionary: JSONDictionary = [
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
        XCTAssertThrowsError(try Dishwasher(dictionary: dictionary)) { error in
            XCTAssertEqual(error as! DishwasherError, DishwasherError.missingDishwasherId)
        }
    }

    func testThrowsErrorWhenTitleIsMissing() {
        let dictionary: JSONDictionary = [
            "productId": "3215462",
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
        XCTAssertThrowsError(try Dishwasher(dictionary: dictionary)) { error in
            XCTAssertEqual(error as! DishwasherError, DishwasherError.missingTitle)
        }
    }

    func testThrowsErrorWhenPricesAreMissing() {
        let dictionary: JSONDictionary = [
            "productId": "3215462",
            "title": "Bosch SMS25AW00G Freestanding Dishwasher, White",
            "image": "//johnlewis.scene7.com/is/image/JohnLewis/236888507?"
        ]
        XCTAssertThrowsError(try Dishwasher(dictionary: dictionary)) { error in
            XCTAssertEqual(error as! DishwasherError, DishwasherError.missingPrice)
        }
    }

    func testDishwasherJsonParseSucceeds() {
        let dishwasher = Factory.createDishwasher()
        XCTAssertEqual(dishwasher.dishwasherId, "3215462")
        XCTAssertEqual(dishwasher.title, "Bosch SMS25AW00G Freestanding Dishwasher, White")
        XCTAssertNotNil(dishwasher.price)
        XCTAssertEqual(dishwasher.rawImage, "//johnlewis.scene7.com/is/image/JohnLewis/236888507?")
    }

    func testDishwashersInitializationSucceeds() {
        let dishwashers = Factory.createDishwashers()
        XCTAssertNotNil(dishwashers)
    }

    func testDishwashersJsonParseSucceeds() {
        let dishwashers = Factory.createDishwashers()
        XCTAssertEqual(dishwashers.count, 20)
    }
}
