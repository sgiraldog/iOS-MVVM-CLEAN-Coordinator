//
//  File.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import Foundation

protocol NetworkClientProtocol {
    func performRequest<T: Codable>(request: URLRequest) async -> Result<T, APIError>
    func decodeData<T: Codable>(data: Data) async -> Result<T, APIError>
}

class NetworkClient: NetworkClientProtocol {
    func performRequest<T: Codable>(request: URLRequest) async -> Result<T, APIError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return .failure(.requestFailed)
            }
            
            return await decodeData(data: data)
        } catch {
            return .failure(.unknown(error))
        }
    }
    
    func decodeData<T: Codable>(data: Data) async -> Result<T, APIError> {
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(T.self, from: data)
            
            return .success(decodedResponse)
        } catch {
            return .failure(.decodingFailed)
        }
    }
}
