//
//  Endpoint.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryParameters: [String: String]?
    let headers: [String: String]?
    let body: Data?
    
    func makeURLRequest() -> URLRequest? {
        guard let url = URL(string: Constants.API.baseURL),
              var components = URLComponents(url: url.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        else { return nil }
        
        if let queryParameters {
            components.queryItems = queryParameters.map({URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
}
