//
//  SplashScreenViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 11.03.2022.
//

import UIKit
import Alamofire

class SplashScreenViewController: UIViewController {
  
  let mainImageView = UIImageView()
  var spinner = UIActivityIndicatorView()
  let spinnerLabel = UILabel()
  let logo = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .secondarySystemBackground
    
    createMainImage()
    createSpinner()
    createSpinnerLabel()
    createLogo()
    setConstraints()
    presentNextController()
  }
  
  func presentNextController() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      guard let viewController = TabBarController().viewControllers?[2] else { return }
//      viewController.modalTransitionStyle = .coverVertical
//      viewController.modalPresentationStyle = .fullScreen
      self.present(viewController, animated: false)
    }
  }
}

// MARK: - Create UI elements & set constraints

extension SplashScreenViewController {

  func createMainImage() {
    mainImageView.image = UIImage(named: "logo")
    mainImageView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func createSpinner() {
    spinner = UIActivityIndicatorView(style: .large)
    spinner.color = .gray
    spinner.startAnimating()
    spinner.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func createSpinnerLabel() {
    spinnerLabel.text = "Загрузка..."
    spinnerLabel.font = UIFont.systemFont(ofSize: 13)
    spinnerLabel.textColor = .darkGray
    spinnerLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func createLogo() {
    logo.image = UIImage(named: "simbirSoft")
    logo.translatesAutoresizingMaskIntoConstraints = false
  }
  
  // Set constraints
  
  func setConstraints() {
    self.view.addSubview(mainImageView)

    NSLayoutConstraint.activate([
      mainImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
      mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      mainImageView.widthAnchor.constraint(equalToConstant: 247),
      mainImageView.heightAnchor.constraint(equalToConstant: 74)
    ])
    
    let spinnerStackView = UIStackView(arrangedSubviews: [spinner, spinnerLabel])
    spinnerStackView.axis = .vertical
    spinnerStackView.spacing = 10
    spinnerStackView.alignment = .center
    spinnerStackView.distribution = .fillProportionally
    spinnerStackView.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(spinnerStackView)
    
    NSLayoutConstraint.activate([
      spinnerStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 88),
      spinnerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      spinnerStackView.widthAnchor.constraint(equalToConstant: 120)
    ])
    
    self.view.addSubview(logo)
    
    NSLayoutConstraint.activate([
      logo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),
      logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logo.widthAnchor.constraint(equalToConstant: 116),
      logo.heightAnchor.constraint(equalToConstant: 15)
    ])
  }
}
