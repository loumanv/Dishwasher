//
//  NetworkClientTests.swift
//  DishwashersTests
//
//  Created by Vasileios Loumanis on 20/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
import Alamofire
@testable import Dishwashers

class MockNetworkSession: NetworkSession {

    var result: Result<Any>?

    func load(_ url: URLConvertible,
              parameters: Parameters?,
              headers: HTTPHeaders?,
              completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let dataResponse = DataResponse(request: nil, response: nil, data: nil, result: result!)
        completionHandler(dataResponse)
    }
}

class NetworkClientTests: XCTestCase {

    let session = MockNetworkSession()
    var networkClient: NetworkClient {
        return NetworkClient(session: session)
    }

    // MARK: - Mocked tests

    func testLoadMethodReturnsErrorForInvalidURL() {
        let expectedError = AppError(localizedTitle: "error", localizedDescription: "error", code: 0)
        session.result = Result.failure(expectedError)

        networkClient.load("invalidURL") { [expectedError] (result, error) in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as! AppError, expectedError)
        }
    }

    func testLoadMethodReturnsResultsForValidURL() {
        let expectedResult = "success"
        session.result = Result.success(expectedResult)

        networkClient.load("validURL") { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            XCTAssertEqual(result as? String, expectedResult)
        }
    }

    func testLoadDishwashersReturnsNoJsonResponseForNoJSONResult() {
        let expectedResult = "No JSON Result"
        session.result = Result.success(expectedResult)

        networkClient.loadDishwashers { (dishwashers, error) in
            XCTAssertNil(dishwashers)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, NetworkClientError.noJsonResponse)
        }
    }

    func testLoadDishwashersReturnsErrorWhenErrorIsNotNil() {
        let expectedError = AppError(localizedTitle: "error", localizedDescription: "error", code: 0)
        session.result = Result.failure(expectedError)

        networkClient.loadDishwashers { (dishwashers, error) in
            XCTAssertNil(dishwashers)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, expectedError)
        }
    }

    func testLoadDishwashersReturnsNilWhenResponseIsNotStructuredProperly() {
        let expectedResult = ["person": "me"]
        session.result = Result.success(expectedResult)

        networkClient.loadDishwashers { (dishwashers, error) in
            XCTAssertNil(dishwashers)
            XCTAssertNil(error)
        }
    }

    func testLoadDishwashersReturnsEmptyArrayOfDishwashersWhenResponseDoesNotHaveDishwashers() {
        let expectedResult = [APIConstants.Dishwasher.dishwashersArrayKey: []]
        session.result = Result.success(expectedResult)

        networkClient.loadDishwashers { (dishwashers, error) in
            XCTAssertNotNil(dishwashers)
            XCTAssertNil(error)
            XCTAssertTrue(dishwashers!.isEmpty)
        }
    }

    func testLoadDishwashersReturnsArrayOfDishwashersWhenResponseHasDishwashers() {
        let expectedResult = [APIConstants.Dishwasher.dishwashersArrayKey: [
                [
                    APIConstants.Dishwasher.dishwasherId: "1",
                    APIConstants.Dishwasher.title: "title",
                    APIConstants.Dishwasher.price: [
                        APIConstants.Price.now: "349.00",
                        APIConstants.Price.currency: "GBP"
                    ]
                ]
            ]
        ]
        session.result = Result.success(expectedResult)

        networkClient.loadDishwashers { (dishwashers, error) in
            XCTAssertNotNil(dishwashers)
            XCTAssertNil(error)
            XCTAssertEqual(dishwashers!.count, 1)
        }
    }

    // MARK: - Tests that make a network request

    func testloadDishwashersMethodSucceeds() {

        let ex = expectation(description: "Expecting dishwashers to not be nil")

        NetworkClient.shared.loadDishwashers { (dishwashers, error) in
            XCTAssertNotNil(dishwashers)
            XCTAssertNil(error)
            ex.fulfill()
        }

        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
}
