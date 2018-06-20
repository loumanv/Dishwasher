//
//  DishwashersViewModelTests.swift
//  DishwashersTests
//
//  Created by Vasileios Loumanis on 19/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Dishwashers

class DishwashersViewModelTests: XCTestCase {

    let viewModel = Factory.createDishwashersViewModel()

    func testDishwashersViewModelInitializationSucceeds() {
        XCTAssertNotNil(viewModel)
    }

    func testDishwasherTitleForRow() {
        XCTAssertEqual(viewModel.title(for: 0), "Bosch SMS25AW00G Freestanding Dishwasher, White")
    }

    func testPriceForRow() {
        XCTAssertEqual(viewModel.price(for: 0), "£349.00")
    }

    func testImageURLForRow() {
        let expectedImageUrl = URL(string: "https://johnlewis.scene7.com/is/image/JohnLewis/236888507?")
        XCTAssertEqual(viewModel.image(for: 0), expectedImageUrl)
    }
}
