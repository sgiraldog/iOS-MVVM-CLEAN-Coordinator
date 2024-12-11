//
//  PeopleViewModel.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import Foundation
import Combine

protocol PeopleViewModelProtocol {
    var coordinator: MainCoordinator { get }
    var viewState: PeopleViewState { get }
    var fetchPeopleListUseCase: FetchPeopleUseCaseProtocol { get }
}

enum PeopleViewState {
    case loading
    case loaded([People])
    case error
}

enum PeopleViewAction {
    case onPeopleTap(String)
    case onRetryTap
}

final class PeopleViewModel: PeopleViewModelProtocol, ObservableObject {
    
    let coordinator: MainCoordinator
    let fetchPeopleListUseCase: FetchPeopleUseCaseProtocol
    @Published var viewState: PeopleViewState = .loading
    
    init(coordinator: MainCoordinator, fetchPeopleListUseCase: FetchPeopleUseCaseProtocol) {
        self.coordinator = coordinator
        self.fetchPeopleListUseCase = fetchPeopleListUseCase
        
        fetchPeopleList()
    }
    
    private func fetchPeopleList() {
        viewState = .loading
        Task { @MainActor in
            let result = await fetchPeopleListUseCase.fetchPeopleList()
            
            switch result {
            case .success(let data):
                viewState = .loaded(data.results)
            case .failure(let failure):
                print(failure.localizedDescription)
                viewState = .error
            }
        }
    }
    
    // MARK: Actions
    
    func handleAction(_ action: PeopleViewAction) {
        switch action {
        case .onPeopleTap(let id):
            coordinator.goToPeopleDetail(id: id)
        case .onRetryTap:
            fetchPeopleList()
        }
    }
}
