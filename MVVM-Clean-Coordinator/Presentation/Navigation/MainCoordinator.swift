//
//  MainCoordinator.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 9/12/24.
//

import SwiftUI

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let networkClient = NetworkClient()
        let service = PeopleService(networkClient: networkClient)
        let repository = PeopleRepository(peopleService: service)
        let useCase = FetchPeopleUseCase(peopleRepository: repository)
        let viewModel = PeopleViewModel(coordinator: self, fetchPeopleListUseCase: useCase)
        let vc = UIHostingController(rootView: PeopleView(viewModel: viewModel))
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToPeopleDetail(id: String) {
        let networkClient = NetworkClient()
        let service = PeopleService(networkClient: networkClient)
        let repository = PeopleRepository(peopleService: service)
        let useCase = FetchPeopleUseCase(peopleRepository: repository)
        let viewModel = PeopleDetailViewModel(id: id, fetchPeopleListUseCase: useCase)
        let vc = UIHostingController(rootView: PeopleDetailView(viewModel: viewModel))
        navigationController.pushViewController(vc, animated: false)
    }
}
