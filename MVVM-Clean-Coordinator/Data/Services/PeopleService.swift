//
//  PeopleService.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import Foundation
import Resolver

protocol PeopleServiceProtocol {
    func fetchPeopleList() async -> Result<FetchPeopleListResponse, APIError>
    func fetchPeople(id: String) async -> Result<People, APIError>
}

class PeopleService: PeopleServiceProtocol {
    @Injected private var networkClient: NetworkClientProtocol
    let apiPath = Constants.API.peoplePath
    
    init() {}
    
    func fetchPeopleList() async -> Result<FetchPeopleListResponse, APIError> {
        let endpoint = Endpoint(
            path: apiPath,
            method: .GET,
            queryParameters: nil,
            headers: nil,
            body: nil
        )
        
        guard let request = endpoint.makeURLRequest() else {
            return .failure(.invalidRequest)
        }
        
        return await networkClient.performRequest(request: request)
    }
    
    func fetchPeople(id: String) async -> Result<People, APIError> {
        let endpoint = Endpoint(
            path: apiPath + id,
            method: .GET,
            queryParameters: nil,
            headers: nil,
            body: nil
        )
        
        guard let request = endpoint.makeURLRequest() else {
            return .failure(.invalidRequest)
        }
        
        return await networkClient.performRequest(request: request)
    }
}
