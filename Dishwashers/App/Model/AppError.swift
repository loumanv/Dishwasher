//
//  AppError.swift
//  Dishwashers
//
//  Created by Vasileios Loumanis on 20/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

struct AppError: Error, Equatable {

    var localizedTitle: String
    var localizedDescription: String
    var code: Int

    init(localizedTitle: String?, localizedDescription: String, code: Int) {
        self.localizedTitle = localizedTitle ?? "Error"
        self.localizedDescription = localizedDescription
        self.code = code
    }
}
