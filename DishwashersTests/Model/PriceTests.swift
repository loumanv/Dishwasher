//
//  PriceTests.swift
//  DishwashersTests
//
//  Created by Vasileios Loumanis on 18/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

import XCTest
@testable import Dishwashers

class PriceTests: XCTestCase {

    func testPriceInitializationSucceeds() {
        let price = Factory.createPrice()
        XCTAssertNotNil(price)
    }

    func testDishwasherJsonParseSucceeds() {
        let price = Factory.createPrice()
        XCTAssertEqual(price.was, "444.50")
        XCTAssertEqual(price.then1, "431.50")
        XCTAssertEqual(price.then2, "421.00")
        XCTAssertEqual(price.now, "349.00")
        XCTAssertEqual(price.uom, "test")
        XCTAssertEqual(price.currency, "GBP")

    }

    func testThrowsErrorWhenNowPriceIsMissing() {
        let dictionary: JSONDictionary = [
            "was": "444.50",
            "then1": "431.50",
            "then2": "421.00",
            "uom": "test",
            "currency": "GBP"
        ]
        XCTAssertThrowsError(try Price(dictionary: dictionary)) { error in
            XCTAssertEqual(error as! PriceError, PriceError.missingNowPrice)
        }
    }

    func testThrowsErrorWhenCurrencyIsMissing() {
        let dictionary: JSONDictionary = [
            "was": "444.50",
            "then1": "431.50",
            "then2": "421.00",
            "now": "349.00",
            "uom": "test"
        ]
        XCTAssertThrowsError(try Price(dictionary: dictionary)) { error in
            XCTAssertEqual(error as! PriceError, PriceError.missingCurrency)
        }
    }
}
