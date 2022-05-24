//
//  UILabel.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 09.05.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, color: UIColor?, numberOfLines: Int) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = .left
        self .numberOfLines = numberOfLines
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
