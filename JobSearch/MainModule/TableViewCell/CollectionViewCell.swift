//
//  CollectionViewCell.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 08.11.2023.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    private var jobTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,
                                 weight: .semibold)
        label.textColor = .black
        return label
    }()
    private var salaryFrom: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,
                                 weight: .bold)
        label.textColor = .black
        return label
    }()
    private var salaryTo: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18,
                                 weight: .bold)
        label.textColor = .black
        return label
    }()
    private var employerLogo: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        return image
    }()
    private var employerNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17,
                                 weight: .regular)
        label.textColor = .black
        return label
    }()
    private var requirementsLabel: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = .systemFont(ofSize: 15,
                                  weight: .regular)
         label.textColor = .black
         return label
     }()
    private var dutiesLabel: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 3
         return label
     }()
    
    private var responsibilityLabel: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 3
         return label
     }()
    private var respondButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("откликнуться",
                        for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        return button
    }()
    private var favoritButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "heart"),
                                  for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    private let briefCase: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "briefcase")
        image.tintColor = .black
        return image
    }()
//MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(jobTitle)
        contentView.addSubview(salaryFrom)
        contentView.addSubview(salaryTo)
        contentView.addSubview(employerLogo)
        contentView.addSubview(employerNameLabel)
        contentView.addSubview(requirementsLabel)
        contentView.addSubview(dutiesLabel)
        contentView.addSubview(responsibilityLabel)
        self.addSubview(respondButton)
        contentView.addSubview(favoritButton)
        contentView.addSubview(briefCase)
        setupeView()
        setupeConstraint()
        setupeButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - setupeView
    private func setupeView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 8
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2,
                                                height: 2)
    }
//MARK: - setupeButton
    private func setupeButton() {
        favoritButton.addTarget(self,
                                action: #selector(favorite),
                                for: .touchUpInside)
    }
    @objc func favorite() {
        if favoritButton.currentBackgroundImage == UIImage(systemName: "heart") {
            favoritButton.setBackgroundImage(UIImage(systemName: "heart.fill"),
                                             for: .normal)
            //action
            print("save vacancy")
            favoritButton.tintColor = .systemRed } else {
            favoritButton.setBackgroundImage(UIImage(systemName: "heart"),
                                             for: .normal)
            //action
            favoritButton.tintColor = .lightGray
        }
    }
//MARK: - configure
    func configure(data: Items) {
        jobTitle.text = data.name
        employerNameLabel.text = data.employer.name
        requirementsLabel.text = data.experience.name
        dutiesLabel.attributedText = data.snippet.requirement.htmlToString
        responsibilityLabel.attributedText = data.snippet.responsibility?.htmlToString
        guard let image = data.employer.logoUrls?.original else { return }
        guard let imageUrl = URL(string: image) else { return }
        employerLogo.sd_setImage(with: imageUrl)
        guard let from = data.salary?.from else { return }
        guard let to = data.salary?.to else { return }
        guard let currency = data.salary?.currency else { return }
        salaryFrom.text = "от \(from) \(currency)"
        salaryTo.text = "до \(to) \(currency)"
    }
//MARK: - setupeConstraint
    private func setupeConstraint() {
        jobTitle.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(16)
            make.width.equalTo(300)
        }
        salaryFrom.snp.makeConstraints { make in
            make.top.equalTo(jobTitle.snp.bottom).inset(-10)
            make.left.equalTo(16)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        salaryTo.snp.makeConstraints { make in
            make.top.equalTo(jobTitle.snp.bottom).inset(-10)
            make.left.equalTo(salaryFrom.snp.right).inset(5)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        employerLogo.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.width.height.equalTo(100)
            make.right.equalTo(-16)
        }
        employerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(salaryFrom.snp.bottom).inset(-20)
            make.left.equalTo(16)
            make.width.equalTo(270)
        }
        requirementsLabel.snp.makeConstraints { make in
            make.top.equalTo(employerNameLabel.snp.bottom).inset(-10)
            make.left.equalTo(briefCase.snp.right).inset(-5)
            make.width.equalTo(270)
        }
        briefCase.snp.makeConstraints { make in
            make.top.equalTo(employerNameLabel.snp.bottom).inset(-11)
            make.left.equalTo(16)
            make.width.equalTo(20)
            make.height.equalTo(15)
        }
        dutiesLabel.snp.makeConstraints { make in
            make.top.equalTo(requirementsLabel.snp.bottom).inset(-10)
            make.left.equalTo(16)
            make.width.equalTo(360)
        }
        responsibilityLabel.snp.makeConstraints { make in
            make.top.equalTo(dutiesLabel.snp.bottom).inset(-10)
            make.left.equalTo(16)
            make.width.equalTo(360)
        }
        favoritButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.right.equalTo(-16)
            make.width.equalTo(30)
            make.height.equalTo(28)
        }
        respondButton.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(35)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-15)
        }
    }
}
