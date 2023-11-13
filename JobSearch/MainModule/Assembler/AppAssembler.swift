//
//  MainAssembler.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 08.11.2023.
//

import UIKit

class MainAssembler: MainAssemblerProtocol {
// MARK: - start
    func start(coordinator: MainCoordinatorProtocol) -> UIViewController {
        let view = MainViewController()
        let viewModel: MainViewModelProtocol = MainViewModel()
        let netWork: NetworkServisProtocol = NetworkServis()
        view.viewModel = viewModel
        viewModel.netWork = netWork
        viewModel.coordinator = coordinator
        return view
    }
// MARK: - createSearchFilterView
    func createSearchFilterView(coordinator: MainCoordinatorProtocol) -> UIViewController {
        let view = SearchFilterView()
        let viewModel: MainViewModelProtocol = MainViewModel()
        view.viewModel = viewModel
        viewModel.coordinator = coordinator
        return view
    } 
// MARK: - createDetailModule
    func createDetailModule(model: Items,
                            coordinator: MainCoordinatorProtocol) -> UIViewController {
        let view = DetailViewController()
        let viewModel: DetailViewModelProtocol = DetailViewModel()
        let netWork: NetworkServisProtocol = NetworkServis()
        view.viewModel = viewModel
        viewModel.netWork = netWork
        viewModel.coordinator = coordinator
        viewModel.model = model
        return view
    }
}
