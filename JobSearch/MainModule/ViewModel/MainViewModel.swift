//
//  MainViewModel.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 08.11.2023.
//

import Foundation

class MainViewModel: MainViewModelProtocol {
    
    var netWork: NetworkServisProtocol?
    var coordinator: MainCoordinatorProtocol?
    var dataModel: Box<JobsData?> = Box(nil)
    private var textString: String?

    lazy var numberOfRowSection: (Int) -> Int = getNumberOfRowSection
    private func getNumberOfRowSection(_ section: Int) -> Int {
        dataModel.value??.items.count ?? 0
    }
    
//MARK: - getSearchText
    func getSearchText(text: String) {
        netWork?.searchVacancies(searchText: text,
                                 id: 20,
                                 completion: { [ weak self ] data in
            DispatchQueue.main.async {
                self?.dataModel.value = data
                self?.textString = text
            }
        })
    }
//MARK: - setsNewData
    func setsNewData() {
        guard let text = textString else { return }
        guard var page = dataModel.value??.perPage else { return }
        page += 20
        netWork?.searchVacancies(searchText: text,
                                  id: page,
                                  completion: { [ weak self ] data in
            DispatchQueue.main.async {
                self?.dataModel.value = data
            }
        })
    }
//MARK: - showDetailView
    func didSelectRowAt(data: Items) {
        coordinator?.showDetail(model: data)
    }
//MARK: - showFilterView
    func showFilterView() {
        coordinator?.showFilterView()
    }
//MARK: - dismiss
    func popToRoot() {
        coordinator?.popToRoot()
    }
}
