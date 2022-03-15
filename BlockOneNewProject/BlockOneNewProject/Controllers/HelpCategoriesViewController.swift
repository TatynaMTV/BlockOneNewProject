//
//  HelpCategoriesViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 12.03.2022.
//

import UIKit

struct HelpCategories {
  let image: UIImage?
  let name: String
}

class HelpCategoriesViewController: UIViewController {
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

  let cellID = "HelpCategoryID"

  let categories: [HelpCategories] = [
    HelpCategories(image: UIImage(named: "children"), name: "Дети"),
    HelpCategories(image: UIImage(named: "adults"), name: "Взрослые"),
    HelpCategories(image: UIImage(named: "elderly"), name: "Пожилые"),
    HelpCategories(image: UIImage(named: "animals"), name: "Животные"),
    HelpCategories(image: UIImage(named: "events"), name: "События")
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    title = "Помочь"

    setupBarButtonItem()
    setupViews()
    setupConstraints()
  }

  func setupBarButtonItem() {
    let barButton = UIButton.init(type: .custom)
    barButton.setBackgroundImage(UIImage(systemName: "chevron.backward"), for: .normal)
    barButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    barButton.tintColor = .white
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barButton)
  }

  func setupViews() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(HelpCategoryCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
  }

  func setupConstraints() {
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

extension HelpCategoriesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categories.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HelpCategoryCollectionViewCell // swiftlint:disable:this force_cast
    cell.setup(with: categories[indexPath.row])
    return cell
  }
}

extension HelpCategoriesViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.size.width / 2 - 15
    let height = CGFloat(160)

    return CGSize(width: width, height: height)
  }
}
