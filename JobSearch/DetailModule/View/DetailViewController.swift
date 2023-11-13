//
//  DetailViewController.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 12.11.2023.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModelProtocol?
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.contentSize = CGSize(width: view.frame.width,
                                  height: view.frame.height)
        return view
    }()
     var employerNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20,
                                 weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
     var salaryFrom: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20,
                                 weight: .semibold)
        label.textColor = .black
        return label
    }()
    var salaryTo: UILabel = {
      let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = .systemFont(ofSize: 20,
                                weight: .semibold)
       label.textColor = .black
       return label
   }()
     var experienceTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15,
                                 weight: .regular)
        label.textColor = .black
        return label
    }()
     var operatingModeTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15,
                                 weight: .regular)
        label.textColor = .black
        return label
    }()
    private let employerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 8
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2,
                                         height: 2)
        return view
    }()
     var employerLogo: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = false
        return image
    }()
    var employerNameTitle: UILabel = {
      let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = .systemFont(ofSize: 18,
                                weight: .semibold)
       label.textColor = .black
       return label
   }()
    var addressTitle: UILabel = {
      let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = .systemFont(ofSize: 15,
                                weight: .regular)
       label.textColor = .black
       return label
   }()
     var jobDescriptionTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20,
                                 weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private let viewButton: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    private var respondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Откликнуться",
                        for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        return button
     }()
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupeView()
        setupeConstraint()
        setupeBarButtonItem()
        viewModel?.viewDidLoad()
        viewModel?.setData(view: self)
    }
//MARK: - setupeView
    private func setupeView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(employerNameLabel)
        scrollView.addSubview(salaryTo)
        scrollView.addSubview(salaryFrom)
        scrollView.addSubview(experienceTitle)
        scrollView.addSubview(operatingModeTitle)
        scrollView.addSubview(employerView)
        employerView.addSubview(employerLogo)
        employerView.addSubview(employerNameTitle)
        employerView.addSubview(addressTitle)
        scrollView.addSubview(jobDescriptionTitle)
        view.addSubview(viewButton)
        viewButton.addSubview(respondButton)
    }
//MARK: - setupeBarButtonItem
    private func setupeBarButtonItem() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(settings))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(share))
        shareButton.tintColor = .black
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(favorite))
        favoriteButton.tintColor = .black
        let hide = UIBarButtonItem(image: UIImage(systemName: "eye.slash"),
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(hide))
        hide.tintColor = .black
        navigationItem.rightBarButtonItems = [favoriteButton, shareButton, hide]
    }
    @objc func settings() {
        viewModel?.backToView()
    }
    @objc func share() {
        print("share")
    }
    @objc func favorite() {
        print("like")
    }
    @objc func hide() {
        print("hide")
    }
//MARK: - setupeConstraint
    private func setupeConstraint() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        employerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(10)
            make.width.equalTo(380)
        }
        salaryFrom.snp.makeConstraints { make in
            make.top.equalTo(employerNameLabel.snp.bottom).inset(-10)
            make.leading.equalTo(10)
            make.width.equalTo(150)
        }
        salaryTo.snp.makeConstraints { make in
            make.top.equalTo(employerNameLabel.snp.bottom).inset(-10)
            make.leading.equalTo(salaryFrom.snp.trailing).inset(-5)
            make.width.equalTo(150)
        }
        experienceTitle.snp.makeConstraints { make in
            make.top.equalTo(salaryFrom.snp.bottom).inset(-5)
            make.leading.equalTo(10)
            make.width.equalTo(380)
        }
        operatingModeTitle.snp.makeConstraints { make in
            make.top.equalTo(experienceTitle.snp.bottom).inset(-5)
            make.leading.equalTo(10)
            make.width.equalTo(380)
        }
        employerView.snp.makeConstraints { make in
            make.top.equalTo(operatingModeTitle.snp.bottom).inset(-10)
            make.leading.equalTo(10)
            make.width.equalToSuperview().inset(10)
            make.height.equalTo(200)
            make.bottom.equalTo(addressTitle.snp.bottom).inset(-10)
        }
        employerLogo.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(10)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        employerNameTitle.snp.makeConstraints { make in
            make.top.equalTo(employerLogo.snp.bottom).inset(-10)
            make.leading.equalTo(10)
            make.width.equalTo(350)
        }
        addressTitle.snp.makeConstraints { make in
            make.top.equalTo(employerNameTitle.snp.bottom).inset(-5)
            make.leading.equalTo(10)
            make.width.equalTo(350)
        }
        jobDescriptionTitle.snp.makeConstraints { make in
            make.top.equalTo(employerView.snp.bottom).inset(-20)
            make.leading.equalTo(10)
            make.width.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        viewButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalToSuperview()
        }
        respondButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(380)
            make.height.equalTo(45)
        }
    }
}
