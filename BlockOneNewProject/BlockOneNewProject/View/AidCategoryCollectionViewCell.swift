//
//  AidCategoryCollectionViewCell.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 14.03.2022.
//

import UIKit

class AidCategoryCollectionViewCell: UICollectionViewCell {

  var categoryImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  var titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "OfficinaSansExtraBoldSCC", size: 17)
    label.textColor = .lightOliveGreen()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let cellID = "AidCategoryID"

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .customBackColor()
    setContsraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setup(with categories: AidCategories) {
    categoryImageView.image = categories.image
    titleLabel.text = categories.name
  }

  // MARK: - Set constraints

  func setContsraints() {
    addSubview(categoryImageView)

    NSLayoutConstraint.activate([
      categoryImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      categoryImageView.topAnchor.constraint(equalTo: topAnchor, constant: 27),
      categoryImageView.widthAnchor.constraint(equalToConstant: 90),
      categoryImageView.heightAnchor.constraint(equalToConstant: 68)
    ])

    addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
