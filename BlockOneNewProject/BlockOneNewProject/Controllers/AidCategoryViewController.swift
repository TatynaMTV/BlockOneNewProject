//
//  AidCategoryViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 22.03.2022.
//

import UIKit
import RealmSwift

class AidCategoryViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите категорию помощи"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .charcoalGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let barButtonItem: UIButton = {
        let barButton = UIButton.init(type: .custom)
        barButton.setBackgroundImage(UIImage(systemName: "chevron.backward"), for: .normal)
        barButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        barButton.tintColor = .white
        return barButton
    }()
    
    private var spinner: UIActivityIndicatorView = {
        var spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .gray
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // variable responsible for the database
    var categories = [CategoryModel]()
    let service = DatabaseService()
    let loadLocalData = DataLoader()
    let urlFireDatabase = "https://blockonenewproject-default-rtdb.firebaseio.com/Categories/.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Помочь"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barButtonItem)
        
        // save and load to database
        service.loadDataFB(type: CategoryModel.self, urlString: urlFireDatabase) { [weak self] result in
            switch result {
            case .success(let category):
                self?.categories = category
                self?.spinner.stopAnimating()
                self?.collectionView.reloadData()
                print("My category: \(category)")
            case .failure(let error):
                print("error:", error)
                self?.loadLocalData.getCategoryType(type: CategoryModel.self, fileName: "category", format: "json") { [weak self] result in
                    switch result {
                    case .success(let categories):
                        self?.categories = categories!
                        DispatchQueue.main.async {
                            self?.spinner.stopAnimating()
                            self?.collectionView.reloadData()
                        }
                    case .failure(let error):
                        print("error:", error)
                    }
                }
            }
        }
        
        setupViews()
        setConstraints()
    }
}

// MARK: - DataSource & Delegate

extension AidCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AidCategoryCollectionViewCell.identifire, for: indexPath) as! AidCategoryCollectionViewCell // swiftlint:disable:this force_cast
        let model = categories[indexPath.row]
        cell.categoryImageView.image = UIImage(named: model.image)
        cell.titleLabel.text = model.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = CharityEventsViewController()
        nextVC.title = categories[indexPath.row].title
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension AidCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width / 2 - 15
        let height = CGFloat(160)
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - Create UI elements & set constraints

extension AidCategoryViewController {
    
    private func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AidCategoryCollectionViewCell.self, forCellWithReuseIdentifier: AidCategoryCollectionViewCell.identifire)
    }
    
    // Set constraints
    private func setConstraints() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 17),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 9),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -9)
        ])
        
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}
