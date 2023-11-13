//
//  DetailProtocols.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 12.11.2023.
//

import UIKit

protocol DetailViewModelProtocol: AnyObject {
    
    var netWork: NetworkServisProtocol? { get set }
    var coordinator: MainCoordinatorProtocol? { get set }
    var model: Items? { get set }
    var items: ItemData? { get set }
    
    func backToView()
    func viewDidLoad()
    func setData(view: DetailViewController)
}


