//
//  DishwashersViewControllerTests.swift
//  DishwashersTests
//
//  Created by Vasileios Loumanis on 20/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Dishwashers

class DishwashersViewControllerTests: XCTestCase {

    func testdishwashersViewControllerTestsInitializationSucceeds() {
        let dishwashersVC = DishwashersViewController()
        XCTAssertNotNil(dishwashersVC)
    }
}
