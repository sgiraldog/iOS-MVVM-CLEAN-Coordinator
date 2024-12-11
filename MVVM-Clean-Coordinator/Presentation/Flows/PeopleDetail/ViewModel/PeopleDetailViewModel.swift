//
//  PeopleViewModel.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import Foundation
import Combine

protocol PeopleDetailViewModelProtocol: ObservableObject {
    var id: String { get }
    var viewState: PeopleDetailViewState { get }
    var fetchPeopleListUseCase: FetchPeopleUseCaseProtocol { get }
    func handleAction(_ action: PeopleDetailViewAction)
}

enum PeopleDetailViewState {
    case loading
    case loaded(People)
    case error
}

enum PeopleDetailViewAction {
    case onRetryTap
}

final class PeopleDetailViewModel: PeopleDetailViewModelProtocol {
    
    let id: String
    let fetchPeopleListUseCase: FetchPeopleUseCaseProtocol
    @Published var viewState: PeopleDetailViewState = .loading
    
    init(id: String, fetchPeopleListUseCase: FetchPeopleUseCaseProtocol) {
        self.id = id
        self.fetchPeopleListUseCase = fetchPeopleListUseCase
        
        fetchPeople()
    }
    
    private func fetchPeople() {
        viewState = .loading
        Task { @MainActor in
            let result = await fetchPeopleListUseCase.fetchPeople(id: id)
            
            switch result {
            case .success(let data):
                viewState = .loaded(data)
            case .failure(let failure):
                print(failure.localizedDescription)
                viewState = .error
            }
        }
    }
    
    // MARK: Actions
    
    func handleAction(_ action: PeopleDetailViewAction) {
        switch action {
        case .onRetryTap:
            fetchPeople()
        }
    }
}
