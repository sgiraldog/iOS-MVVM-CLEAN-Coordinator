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

    init() {
        navigationController = UINavigationController()
    }

    func start() {
        let viewModel = PeopleViewModel()
        let vc = UIHostingController(rootView: PeopleView(viewModel: viewModel))
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToPeopleDetail(id: String) {
        let viewModel = PeopleDetailViewModel(id: id)
        let vc = UIHostingController(rootView: PeopleDetailView(viewModel: viewModel))
        navigationController.pushViewController(vc, animated: false)
    }
}
