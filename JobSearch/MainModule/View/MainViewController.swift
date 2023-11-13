//
//  MainViewController.swift
//  JobSearch
//
//  Created by Vasiliy Vygnych on 08.11.2023.
//
import UIKit
import SnapKit


class MainViewController: UIViewController {

    var viewModel: MainViewModelProtocol?
    var search = UISearchController(searchResultsController: nil)
    private var activityIndicator = UIActivityIndicatorView()
    private var viewCell = "viewCell"
    
    var model: [Items?] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
  
// MARK: - titleLabel
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20,
                                 weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Введите в поиск название и появится список вакансий"
        return label
    }()
// MARK: - сollectionViewFlowLayout
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 400,
                                height: 310)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 10,
                                    left: 0,
                                    bottom: 10,
                                    right: 0)
        return layout
    }()
// MARK: - collectionView
    private lazy var collectionView: UICollectionView = {
       let collectionView = UICollectionView(frame: .zero,
                                             collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
       return collectionView
   }()
// MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel?.dataModel.bind { data in
            guard let modelData = data??.items else { return }
            self.model = modelData
        }
        setupcollectionView()
        setupeSearch()
        setupeBarButtonItem()
        setupeIndicator()
        setupeConstarsint()
    }
// MARK: - setupeBarButtonItem
    func setupeBarButtonItem() {
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "slider.vertical.3"),
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(settings))
        settingsButton.tintColor = .black
        navigationItem.rightBarButtonItem = settingsButton
    }
    @objc func settings() {
        viewModel?.showFilterView()
    }
// MARK: - setupcollectionView
    private func setupcollectionView() {
        view.addSubview(collectionView)
        collectionView.addSubview(titleLabel)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: viewCell)
    }
// MARK: - setupeSearch
    private func setupeSearch() {
        search.searchResultsUpdater = self
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.placeholder = "Должность, ключевые слова"
        navigationItem.titleView = search.searchBar
    }
// MARK: - setupeIndicator
    private func setupeIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
// MARK: - setupeConstrsint
    private func setupeConstarsint() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.centerX.equalToSuperview()
        }
    }
}
// MARK: - extension for UICollectionView
extension MainViewController: UICollectionViewDataSource,
                              UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel?.numberOfRowSection(section) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewCell,
                                                      for: indexPath) as? CollectionViewCell,
             let model = model[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(data: model)
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        return cell
    }
// MARK: - willDisplay
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        var pageCount = model.count
        let total = 2000
        if indexPath.row == model.count - 3 && model.count < total {
            pageCount += 20
            viewModel?.setsNewData()
        }
    }
// MARK: - didSelectItemAt
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let collectionView = self.collectionView.cellForItem(at: indexPath)
        guard let model = model[indexPath.row] else { return }
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            collectionView?.transform = CGAffineTransform(scaleX: 0.75,
                                                          y: 0.75)
            collectionView?.contentView.backgroundColor = .lightGray
            collectionView?.contentView.alpha = 0.4
        }, completion: { finished in
            self.viewModel?.didSelectRowAt(data: model)
        })
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            collectionView?.transform = CGAffineTransform(scaleX: 1,
                                                          y: 1)
            collectionView?.contentView.backgroundColor = .white
        }, completion: nil)
    }
}
// MARK: - extension UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            titleLabel.isHidden = true
        } else {
            titleLabel.removeFromSuperview()
        }
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.count > 3 {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                self.activityIndicator.startAnimating()
                self.viewModel?.getSearchText(text: searchText)
            })
        }
    }
}
