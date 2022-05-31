//
//  AidCategoryViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 22.03.2022.
//

import UIKit

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
    
    private let titlePhoto: [UIImage] = [
        UIImage(named: "children"),
        UIImage(named: "adults"),
        UIImage(named: "elderly"),
        UIImage(named: "animals"),
        UIImage(named: "events")
    ].compactMap({ $0 })
    
    let data = DataLoader().categoryData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Помочь"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barButtonItem)
        
        setupViews()
        setConstraints()
    }
}

// MARK: - DataSource & Delegate

extension AidCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AidCategoryCollectionViewCell.identifire, for: indexPath) as! AidCategoryCollectionViewCell // swiftlint:disable:this force_cast
        cell.categoryImageView.image = titlePhoto[indexPath.row]
        cell.titleLabel.text = data[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = CharityEventsViewController()
        nextVC.title = data[indexPath.row].title
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
    }
}

// MARK: - SwiftUI Canvas
import SwiftUI
struct AidProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        
        let viewController = AidCategoryViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<AidProvider.ContainterView>) -> AidCategoryViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: AidProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<AidProvider.ContainterView>) {
        }
    }
}
