//
//  MainProtocol.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 08.11.2023.
//

import UIKit

protocol MainAssemblerProtocol: AnyObject {
    func start(coordinator: MainCoordinatorProtocol) -> UIViewController
    func createSearchFilterView(coordinator: MainCoordinatorProtocol) -> UIViewController
    func createDetailModule(model: Items,
                            coordinator: MainCoordinatorProtocol) -> UIViewController
}

protocol MainCoordinatorProtocol: AnyObject {
    func start()
    func showFilterView()
    func showDetail(model: Items)
    func popToRoot()
}

protocol MainViewModelProtocol: AnyObject {
    var netWork: NetworkServisProtocol? { get set }
    var coordinator: MainCoordinatorProtocol? { get set }
    var dataModel: Box<JobsData?> { get set }
    var numberOfRowSection: (_ section: Int) -> Int { get }
    
    func getSearchText(text: String)
    func setsNewData()
    func showFilterView()
    func didSelectRowAt(data: Items)
    func popToRoot()
}

protocol NetworkServisProtocol: AnyObject {
    func searchVacancies(searchText: String,
                        id: Int,
                        completion: @escaping (JobsData?) -> Void)
    func detailVacancies(id: String,
                         completion: @escaping (ItemData?) -> Void)
}
