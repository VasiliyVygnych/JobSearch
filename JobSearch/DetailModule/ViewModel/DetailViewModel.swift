//
//  DetailViewModel.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 12.11.2023.
//

import Foundation
import SDWebImage

class DetailViewModel: DetailViewModelProtocol {
    
    var netWork: NetworkServisProtocol?
    var coordinator: MainCoordinatorProtocol?
    var model: Items?
    var items: ItemData?

    func viewDidLoad() {
        guard let id = model?.id else { return }
        netWork?.detailVacancies(id: id,
                              completion: { [ weak self ] data in
            DispatchQueue.main.async {
                self?.items = data
            }
        })
    }
    func setData(view: DetailViewController) {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5 ) { [self] in
            guard let model = items else { return }
            view.employerNameLabel.text = model.name
            view.experienceTitle.text = "Требуемый опыт: \(model.experience.name)" 
            view.operatingModeTitle.text = model.schedule.name
            view.employerNameTitle.text = model.employer.name
            view.addressTitle.text = model.address?.raw
            view.jobDescriptionTitle.attributedText = items?.description.htmlToString
            guard let image = items?.employer.logoUrls?.original else { return }
            guard let imageUrl = URL(string: image) else { return }
            view.employerLogo.sd_setImage(with: imageUrl)
            guard let salaryFrom = items?.salary?.from else { return }
            guard let salaryTo = items?.salary?.to else { return }
            guard let currency = items?.salary?.currency else { return }
            view.salaryFrom.text = "от \(salaryFrom) \(currency)"
            view.salaryTo.text = "до \(salaryTo) \(currency)"
        }
    }
    func backToView() {
        coordinator?.popToRoot()
    }
}
