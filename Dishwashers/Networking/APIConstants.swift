//
//  APIConstants.swift
//  Dishwashers
//
//  Created by Vasileios Loumanis on 18/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

struct APIConstants {

    struct Price {
        static let was = "was"
        static let then1 = "then1"
        static let then2 = "then2"
        static let now = "now"
        static let uom = "uom"
        static let currency = "currency"
    }

    struct Dishwasher {
        static let dishwashersArrayKey = "products"
        static let dishwasherId = "productId"
        static let title = "title"
        static let price = "price"
        static let rawImage = "image"
    }

    struct UrlStrings {
        static let baseUrl = "https://api.johnlewis.com"
        static let products = "/v1/products"
        static let search = "/search"
        static let queryKey = "q"
        static let queryValue = "dishwasher"
        static let authkey = "key"
        static let authValue = "Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
        static let pageSizeKey = "pageSize"
        static let pageSizeValue = "20"
    }
}
