//
//  CharityEventCollectionViewCell.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 22.03.2022.
//

import UIKit

class CharityEventCollectionViewCell: UICollectionViewCell {
  let imageView = UIImageView()
  let blurEffect = UIImageView()
  let titleLabel = UILabel()
  let heartImage = UIImageView()
  let textLabel = UILabel()
  let bottomView = UIView()
  let bottomImageView = UIImageView()
  let bottomDateLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 10
    
    setView()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  func setup(with events: CharityEvents) {
    imageView.image = events.image
    titleLabel.text = events.titleLable
    textLabel.text = events.textLable
    bottomDateLabel.text = events.bottomLabel
  }
}

// MARK: - Set View & Constraints

extension CharityEventCollectionViewCell {
  func setView() {
    imageView.image = UIImage(named: "image1")
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 10
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    blurEffect.image = UIImage(named: "blurEffect")
    blurEffect.contentMode = .scaleAspectFill
    blurEffect.layer.cornerRadius = 10
    blurEffect.layer.masksToBounds = true
    blurEffect.translatesAutoresizingMaskIntoConstraints = false
    
    titleLabel.text = ""
    titleLabel.numberOfLines = 2
    titleLabel.textAlignment = .center
    titleLabel.textColor = .blueGrey()
    titleLabel.layer.cornerRadius = 5
    titleLabel.layer.masksToBounds = true
    titleLabel.font = UIFont(name: "OfficinaSansExtraBoldSCC", size: 25)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    heartImage.image = UIImage(named: "heart")
    heartImage.contentMode = .scaleAspectFill
    heartImage.translatesAutoresizingMaskIntoConstraints = false
    
    textLabel.text = ""
    textLabel.numberOfLines = 3
    textLabel.textAlignment = .center
    textLabel.textColor = .darkSlateBlue()
    textLabel.font = UIFont(name: "SFUIText-regular", size: 15)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    
    bottomView.backgroundColor = .greenLeaf()
    bottomView.translatesAutoresizingMaskIntoConstraints = false
    
    bottomImageView.image = UIImage(systemName: "calendar")
    bottomImageView.contentMode = .scaleAspectFit
    bottomImageView.tintColor = .white
    bottomImageView.translatesAutoresizingMaskIntoConstraints = false
    
    bottomDateLabel.text = ""
    bottomDateLabel.textAlignment = .left
    bottomDateLabel.textColor = .white
    bottomDateLabel.font = UIFont.systemFont(ofSize: 13)
    bottomDateLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func setConstraints() {
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
      imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
      imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
      imageView.heightAnchor.constraint(equalToConstant: self.frame.size.height / 1.8)
    ])
    
    imageView.addSubview(blurEffect)
    
    NSLayoutConstraint.activate([
      blurEffect.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
      blurEffect.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
      blurEffect.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
      blurEffect.heightAnchor.constraint(equalToConstant: 140)
    ])
    
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -15),
      titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 54),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -54),
      titleLabel.heightAnchor.constraint(equalToConstant: 55)
    ])
    
    addSubview(heartImage)
    
    NSLayoutConstraint.activate([
      heartImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
      heartImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      heartImage.widthAnchor.constraint(equalToConstant: 113),
      heartImage.heightAnchor.constraint(equalToConstant: 15)
    ])
    
    addSubview(textLabel)
    
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: heartImage.bottomAnchor, constant: 8),
      textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      textLabel.widthAnchor.constraint(equalToConstant: 313),
      textLabel.heightAnchor.constraint(equalToConstant: 70)
    ])
    
    addSubview(bottomView)
    
    NSLayoutConstraint.activate([
      bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      bottomView.heightAnchor.constraint(equalToConstant: 31)
    ])
    
    let bottomDateStackView = UIStackView(arrangedSubviews: [bottomImageView, bottomDateLabel], axis: .horizontal, spacing: 10, distribution: .fillProportionally)
    
    bottomView.addSubview(bottomDateStackView)
    
    NSLayoutConstraint.activate([
      bottomDateStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5),
      bottomDateStackView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
      bottomDateStackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -8)
    ])
  }
}
