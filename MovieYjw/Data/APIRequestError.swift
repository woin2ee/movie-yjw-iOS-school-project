//
//  APIRequestError.swift
//  MovieYjw
//
//  Created by Jaewon on 2022/06/08.
//

import Foundation

enum APIRequestError: Error {
    case invalidURL
    case failureStatusCode
    case missingData
    case decodeError
    case anyError(_: Error)
}
