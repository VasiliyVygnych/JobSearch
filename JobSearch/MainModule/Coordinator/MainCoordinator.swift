//
//  MainCoordinator.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 08.11.2023.
//

import UIKit


class MainCoordinator: MainCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: MainAssemblerProtocol
    
    init(assembler: MainAssemblerProtocol = MainAssembler(),
         navigationController: UINavigationController) {
        self.assembler = assembler
        self.navigationController = navigationController
    }
// MARK: - start
    func start() {
        if let navigationController = navigationController {
            let view = assembler.start(coordinator: self)
            navigationController.viewControllers = [view]
        }
    }
// MARK: - showDetail
    func showDetail(model: Items) {
        if let navigationController = navigationController {
            let detailViewController = assembler.createDetailModule(model: model,
                                                                    coordinator: self)
            navigationController.pushViewController(detailViewController,
                                                    animated: true)
        }
    }
// MARK: - showFilterView
    func showFilterView() {
        if let navigationController = navigationController {
            let view = assembler.createSearchFilterView(coordinator: self)
            navigationController.present(view,
                                         animated: true)
        }
    }
// MARK: - popToRoot
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
