//
//  PeopleViewModel.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import Foundation
import Combine
import Resolver

protocol PeopleViewModelProtocol: ObservableObject {
    var coordinator: MainCoordinator { get }
    var viewState: PeopleViewState { get }
    var fetchPeopleListUseCase: FetchPeopleUseCaseProtocol { get }
    func handleAction(_ action: PeopleViewAction)
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

final class PeopleViewModel: PeopleViewModelProtocol {
    
    @Injected var coordinator: MainCoordinator
    @Injected var fetchPeopleListUseCase: FetchPeopleUseCaseProtocol
    @Published var viewState: PeopleViewState = .loading
    
    init() {
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
