//
//  SearchFilterView.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 11.11.2023.
//

import UIKit
import SnapKit

class SearchFilterView: UIViewController {
    
    var viewModel: MainViewModelProtocol?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,
                                 weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "тут мог быть фильтр поиска вакансий и более красивая анимация появления и исчезновения, может когда-нибудь и будет.."
        return label
    }()
    
    private var enterButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("применить",
                        for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(enterButton)
        setupeConstraint()
        setupeButton()
    }
    
    func setupeButton() {
        enterButton.addTarget(self,
                              action: #selector(enter),
                              for: .touchUpInside)
    }
    @objc func enter() {
//        viewModel?.popToRoot()
        dismiss(animated: true)
    }
    
    private func setupeConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(10)
            make.top.equalTo(200)
        }
        enterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(35)
            make.bottom.equalTo(-50)
        }
    }
}
