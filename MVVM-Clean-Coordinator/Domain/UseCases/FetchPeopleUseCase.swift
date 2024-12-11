//
//  FetchPeopleUseCase.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import Foundation
import Resolver

protocol FetchPeopleUseCaseProtocol {
    func fetchPeopleList() async -> Result<FetchPeopleListResponse, APIError>
    func fetchPeople(id: String) async -> Result<People, APIError>
}

class FetchPeopleUseCase: FetchPeopleUseCaseProtocol {
    @Injected private var peopleRepository: PeopleRepositoryProtocol
    
    init() {}
    
    func fetchPeopleList() async -> Result<FetchPeopleListResponse, APIError> {
        return await peopleRepository.fetchPeopleList()
    }
    
    func fetchPeople(id: String) async -> Result<People, APIError> {
        return await peopleRepository.fetchPeople(id: id)
    }
}
