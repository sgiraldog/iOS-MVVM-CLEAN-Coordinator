//
//  Coordinator.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 9/12/24.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
