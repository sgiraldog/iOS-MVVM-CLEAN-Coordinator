//
//  APIError.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//
import Foundation

enum APIError: Error {
    case invalidRequest
    case requestFailed
    case decodingFailed
    case unknown(Error)
}
