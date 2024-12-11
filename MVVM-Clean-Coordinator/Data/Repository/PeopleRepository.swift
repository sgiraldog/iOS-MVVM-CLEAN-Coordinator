//
//  PeopleRepository.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import Foundation
import Resolver

protocol PeopleRepositoryProtocol {
    func fetchPeopleList() async -> Result<FetchPeopleListResponse, APIError>
    func fetchPeople(id: String) async -> Result<People, APIError>
}

final class PeopleRepository: PeopleRepositoryProtocol {
    @Injected private var peopleService: PeopleServiceProtocol
    
    init() {}
    
    func fetchPeopleList() async -> Result<FetchPeopleListResponse, APIError> {
        return await peopleService.fetchPeopleList()
    }
    
    func fetchPeople(id: String) async -> Result<People, APIError> {
        return await peopleService.fetchPeople(id: id)
    }
}
