//
//  DeteilCharityEventViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 25.03.2022.
//

import UIKit

class DetailCharityEventViewController: UIViewController {
    let titleNameLabel = UILabel(text: "Спонсоры отремонтируют школу-интернат",
                                 font: UIFont(name: "OfficinaSansExtraBoldSCC", size: 25),
                                 color: .blueGrey(),
                                 numberOfLines: 2)
    let calendarImageView = UIImageView()
    let countdownTimerLabel = UILabel(text: "Осталось 13 дней (21.09 – 20.10)",
                                      font: .systemFont(ofSize: 11),
                                      color: .gray,
                                      numberOfLines: 1)
    var countdownTimerStackView = UIStackView()
    
    let fondNameLable = UILabel(text: "Благотворительный фонд «Счастливый Мир»",
                                font: .systemFont(ofSize: 13),
                                color: .charcoalGrey(),
                                numberOfLines: 1)
    
    let locationImageView = UIImageView()
    let addressLabel = UILabel(text: "Санкт-Петербург, Кирочная улица, д. 50А, каб. 208",
                               font: .systemFont(ofSize: 20),
                               color: .charcoalGrey(),
                               numberOfLines: 2)
    var locationStackView = UIStackView()
    
    let phoneImageView = UIImageView()
    let phoneLabel = UILabel(text: "+7 (937) 037 37-73\n+7 (937) 016 16-16",
                               font: .systemFont(ofSize: 20),
                               color: .charcoalGrey(),
                               numberOfLines: 2)
    var phoneStackView = UIStackView()
    
    let mailImageView = UIImageView()
    let mailLabel = UILabel(text: "У вас есть вопросы? Напишите нам.",
                               font: .systemFont(ofSize: 18),
                               color: .charcoalGrey(),
                               numberOfLines: 1)
    var mailStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setConstraints()
    }
    
    func createAtributeString() {

    }
}

// MARK: - Create UI elements & set constraints

extension DetailCharityEventViewController {
    private func setupView() {
        calendarImageView.image = UIImage(systemName: "calendar")
        calendarImageView.tintColor = .gray
        calendarImageView.contentMode = .scaleAspectFill
        calendarImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        calendarImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        
        countdownTimerStackView = UIStackView(arrangedSubviews: [calendarImageView, countdownTimerLabel],
                                                  axis: .horizontal,
                                                  spacing: 10,
                                                  distribution: .fillProportionally)
        locationImageView.image = UIImage(systemName: "location.fill")
        locationImageView.tintColor = .charcoalGrey()
        locationImageView.contentMode = .scaleAspectFit
        locationImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        locationImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        locationStackView = UIStackView(arrangedSubviews: [locationImageView, addressLabel],
                                        axis: .horizontal,
                                        spacing: 10,
                                        distribution: .fillProportionally)
        
        phoneImageView.image = UIImage(systemName: "phone.fill")
        phoneImageView.tintColor = .charcoalGrey()
        phoneImageView.contentMode = .scaleAspectFit
        phoneImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        phoneImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        phoneStackView = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel],
                                        axis: .horizontal,
                                        spacing: 10,
                                        distribution: .fillProportionally)
        
        mailImageView.image = UIImage(systemName: "envelope.fill")
        mailImageView.tintColor = .charcoalGrey()
        mailImageView.contentMode = .scaleAspectFit
        mailImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        mailImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        mailStackView = UIStackView(arrangedSubviews: [mailImageView, mailLabel],
                                        axis: .horizontal,
                                        spacing: 10,
                                        distribution: .fillProportionally)
    }
    
    private func setConstraints() {
        view.addSubview(titleNameLabel)
        
        NSLayoutConstraint.activate([
            titleNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(countdownTimerStackView)
        
        NSLayoutConstraint.activate([
            countdownTimerStackView.topAnchor.constraint(equalTo: titleNameLabel.bottomAnchor, constant: 10),
            countdownTimerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countdownTimerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            countdownTimerLabel.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        view.addSubview(fondNameLable)
        
        NSLayoutConstraint.activate([
            fondNameLable.topAnchor.constraint(equalTo: countdownTimerStackView.bottomAnchor, constant: 10),
            fondNameLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fondNameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fondNameLable.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(locationStackView)
        
        NSLayoutConstraint.activate([
            locationStackView.topAnchor.constraint(equalTo: fondNameLable.bottomAnchor, constant: 16),
            locationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(phoneStackView)
        
        NSLayoutConstraint.activate([
            phoneStackView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: 16),
            phoneStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(mailStackView)
        
        NSLayoutConstraint.activate([
            mailStackView.topAnchor.constraint(equalTo: phoneStackView.bottomAnchor, constant: 16),
            mailStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mailStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mailStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: - SwiftUI Canvas
import SwiftUI

struct NewProvider: PreviewProvider {
  static var previews: some View {
      Group {
          ContainterView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
      }
  }
  
  struct ContainterView: UIViewControllerRepresentable {
    
    let viewController = DetailCharityEventViewController()
    func makeUIViewController(context: UIViewControllerRepresentableContext<NewProvider.ContainterView>) -> DetailCharityEventViewController {
      return viewController
    }
    
    func updateUIViewController(_ uiViewController: NewProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<NewProvider.ContainterView>) {
    }
  }
}
