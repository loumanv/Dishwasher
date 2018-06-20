//
//  NetworkClient.swift
//  Dishwashers
//
//  Created by Vasileios Loumanis on 20/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Alamofire

typealias JSONDictionary = [String: Any]

struct NetworkClientError {
    static let noJsonResponse = AppError(localizedTitle: "No JSON Response",
                                         localizedDescription: "Not a JSON Response", code: 0)
}

protocol NetworkSession {
    func load(_ url: URLConvertible,
              parameters: Parameters?,
              headers: HTTPHeaders?,
              completionHandler: @escaping (DataResponse<Any>) -> Void)
}

extension SessionManager: NetworkSession {
    func load(_ url: URLConvertible,
              parameters: Parameters?,
              headers: HTTPHeaders?,
              completionHandler: @escaping (DataResponse<Any>) -> Void) {

        request(url, parameters: parameters, headers: headers).responseJSON { response in
            completionHandler(response)
        }
    }
}

class NetworkClient {

    public static let shared = NetworkClient()

    private let session: NetworkSession

    init(session: NetworkSession = SessionManager.default) {
        self.session = session
    }

    func load(_ url: URLConvertible,
              parameters: Parameters? = nil,
              headers: HTTPHeaders? = nil,
              completion: @escaping ((Any?, Error?) -> Void)) {

        session.load(url, parameters: parameters, headers: headers) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)

            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func loadDishwashers(completion: @escaping (([Dishwasher]?, AppError?) -> Void)) {

        load(dishwashersUrl(), parameters: dishwashersParameters()) { (data, error) in

                guard error == nil,
                    let data = data,
                    let json = data as? JSONDictionary else {
                        if let error = error {
                            completion(nil, error as? AppError)
                        } else {
                            completion(nil, NetworkClientError.noJsonResponse)
                        }
                        return
                }

                let dishwashers = Dishwasher.array(json: json)
                completion(dishwashers, nil)
        }
    }

    private func dishwashersUrl() -> String {
        return APIConstants.UrlStrings.baseUrl + APIConstants.UrlStrings.products + APIConstants.UrlStrings.search
    }

    private func dishwashersParameters() -> Parameters {
        return [APIConstants.UrlStrings.queryKey: APIConstants.UrlStrings.queryValue,
                APIConstants.UrlStrings.authkey: APIConstants.UrlStrings.authValue,
                APIConstants.UrlStrings.pageSizeKey: APIConstants.UrlStrings.pageSizeValue]
    }
}
