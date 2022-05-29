//
//  PhotoEvetnCollectionViewCell.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 29.05.2022.
//

import UIKit

class PhotoEvetnCollectionViewCell: UICollectionViewCell {
    static let identifire = "PhotoEvetnCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "photo1")
        return imageView
    }()

    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}
