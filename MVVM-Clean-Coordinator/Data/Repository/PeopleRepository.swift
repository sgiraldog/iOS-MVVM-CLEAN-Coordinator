//
//  PeopleRepository.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import Foundation

protocol PeopleRepositoryProtocol {
    func fetchPeopleList() async -> Result<FetchPeopleListResponse, APIError>
    func fetchPeople(id: String) async -> Result<People, APIError>
}

final class PeopleRepository: PeopleRepositoryProtocol {
    let peopleService: PeopleServiceProtocol
    
    init(peopleService: PeopleServiceProtocol) {
        self.peopleService = peopleService
    }
    
    func fetchPeopleList() async -> Result<FetchPeopleListResponse, APIError> {
        return await peopleService.fetchPeopleList()
    }
    
    func fetchPeople(id: String) async -> Result<People, APIError> {
        return await peopleService.fetchPeople(id: id)
    }
}
