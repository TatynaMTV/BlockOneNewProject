//
//  DeteilCharityEventViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 25.03.2022.
//

import UIKit

class DetailCharityEventViewController: UIViewController {
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width,
                                      height: self.view.frame.height + 50)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 146)
        scrollView.backgroundColor = .white
        scrollView.contentSize = contentViewSize
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    private let barButtonItem: UIButton = {
      let barButton = UIButton.init(type: .custom)
      barButton.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
      barButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
      barButton.tintColor = .white
      return barButton
    }()
    
    public let titleNameLabel = UILabel(text: "Спонсоры отремонтируют школу-интернат",
                                         font: UIFont(name: "OfficinaSansExtraBoldSCC", size: 25),
                                         color: .blueGrey(),
                                         numberOfLines: 2)
    private let calendarImageView = UIImageView()
    public let countdownTimerLabel = UILabel(text: "Осталось 13 дней (21.09 – 20.10)",
                                              font: .systemFont(ofSize: 11),
                                              color: .gray,
                                              numberOfLines: 1)
    private var countdownTimerStackView = UIStackView()
    
    public let fondNameLable = UILabel(text: "Благотворительный фонд «Счастливый Мир»",
                                        font: .systemFont(ofSize: 13),
                                        color: .charcoalGrey(),
                                        numberOfLines: 1)
    
    private var locationStackView = UIStackView()
    private let locationImageView = UIImageView()
    public let addressLabel = UILabel(text: "Санкт-Петербург, Кирочная улица, д. 50А, каб. 208",
                                       font: .systemFont(ofSize: 20),
                                       color: .charcoalGrey(),
                                       numberOfLines: 2)
    
    private var phoneStackView = UIStackView()
    private let phoneImageView = UIImageView()
    public let phoneLabel = UILabel(text: "+7 (937) 037 37-73\n+7 (937) 016 16-16",
                                     font: .systemFont(ofSize: 20),
                                     color: .charcoalGrey(),
                                     numberOfLines: 2)
    
    private var mailStackView = UIStackView()
    private let mailImageView = UIImageView()
    private let mailLabel = UILabel(text: "У вас есть вопросы? Напишите нам.",
                                    font: .systemFont(ofSize: 18),
                                    color: .charcoalGrey(),
                                    numberOfLines: 1)
    
    private let participsntsView = UIView()
    private var participantsCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let participsntsCounter = UILabel(text: "+102", font: .systemFont(ofSize: 13), color: .gray, numberOfLines: 1)
    
    private let huperTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Перейти на сайт организации"
        return textView
    }()
    
    private let photosContainerView = UIView()
    private var photosEvent: UICollectionView!
    
    private let descriptionEvent = UITextView()

    let images: [UIImage] = [
        UIImage(named: "image1"),
        UIImage(named: "image3"),
        UIImage(named: "image4")
    ].compactMap({ $0 })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backItem?.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButtonItem)
        
        createParticipantsStackView()
        setupView()
        setupCollectionView()
        setConstraints()
        
        createHuperText()
    }
    
    // Cerate stackView for photos
    
    func createParticipantsStackView() {
        for index in 0..<5 {
            let arrayParticipants = [
                UIImage(named: "photo1"),
                UIImage(named: "photo2"),
                UIImage(named: "photo3"),
                UIImage(named: "photo4"),
                UIImage(named: "photo5")
            ]
            let view = UIImageView()
            view.image = arrayParticipants[index]
            view.frame.size = CGSize(width: 36, height: 36)
            participantsCountStackView.addArrangedSubview(view)
        }
    }
    
    // HuperText
    func createHuperText() {
        let attributeString = NSMutableAttributedString(string: "Перейти на сайт организации")
        attributeString.addAttribute(.link, value: "https://www.google.com", range: NSRange(location: 0, length: 27))
        huperTextView.attributedText = attributeString
        
    }
    
// MARK: - Create compositional layout
    
    func setupCollectionView() {
        photosEvent = UICollectionView(frame: photosContainerView.bounds, collectionViewLayout: createCompositionalLayout())
        photosEvent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        photosEvent.register(PhotoEvetnCollectionViewCell.self, forCellWithReuseIdentifier: PhotoEvetnCollectionViewCell.identifire)
        photosEvent.backgroundColor = .white
        photosContainerView.addSubview(photosEvent)
        
        photosEvent.delegate = self
        photosEvent.dataSource = self
    }

    private func createCompositionalLayout() -> UICollectionViewLayout {
        // items -> group -> sector -> return
        let mainItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .fractionalHeight(1.0)))
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let verticalStackItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)))
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let verticalStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                               heightDimension: .fractionalHeight(1.0)),
            subitem: verticalStackItem, count: 2)
        let mainGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)),
            subitems: [mainItem, verticalStackGroup])
        
        let section = NSCollectionLayoutSection(group: mainGroup)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - TExt View Delegate

extension DetailCharityEventViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}

// MARK: - CollectionViewDelegate & CollectionViewDataSource

extension DetailCharityEventViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoEvetnCollectionViewCell.identifire, for: indexPath) as! PhotoEvetnCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        return cell
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
        
        photosContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionEvent.text = """
        Участники и болельщики смогли весело и активно провести время на «Петербургском благотворительном марафоне» и при этом финансово поучаствовать в помощи детям.
        
        При этом финансово поучаствовать в помощи детям. При этом финансово поучаствовать в помощи детям.
        """
        descriptionEvent.textColor = .charcoalGrey()
        descriptionEvent.font = .systemFont(ofSize: 20)
        descriptionEvent.textAlignment = .left
        descriptionEvent.translatesAutoresizingMaskIntoConstraints = false
        
        participsntsView.backgroundColor = .lightGrey()
        participsntsView.translatesAutoresizingMaskIntoConstraints = false
        
        huperTextView.backgroundColor = .white
        huperTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(titleNameLabel)
        NSLayoutConstraint.activate([
            titleNameLabel.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        containerView.addSubview(countdownTimerStackView)
        NSLayoutConstraint.activate([
            countdownTimerStackView.topAnchor.constraint(equalTo: titleNameLabel.bottomAnchor, constant: 10),
            countdownTimerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            countdownTimerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            countdownTimerLabel.heightAnchor.constraint(equalToConstant: 13)
        ])
        
        containerView.addSubview(fondNameLable)
        NSLayoutConstraint.activate([
            fondNameLable.topAnchor.constraint(equalTo: countdownTimerStackView.bottomAnchor, constant: 10),
            fondNameLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            fondNameLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            fondNameLable.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        containerView.addSubview(locationStackView)
        NSLayoutConstraint.activate([
            locationStackView.topAnchor.constraint(equalTo: fondNameLable.bottomAnchor, constant: 16),
            locationStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            locationStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            locationStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        containerView.addSubview(phoneStackView)
        NSLayoutConstraint.activate([
            phoneStackView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: 16),
            phoneStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            phoneStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            phoneStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        containerView.addSubview(mailStackView)
        NSLayoutConstraint.activate([
            mailStackView.topAnchor.constraint(equalTo: phoneStackView.bottomAnchor, constant: 16),
            mailStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            mailStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            mailStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        containerView.addSubview(photosContainerView)
        NSLayoutConstraint.activate([
            photosContainerView.topAnchor.constraint(equalTo: mailStackView.bottomAnchor, constant: 16),
            photosContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            photosContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            photosContainerView.heightAnchor.constraint(equalToConstant: 173)
        ])
        
        containerView.addSubview(descriptionEvent)
        NSLayoutConstraint.activate([
            descriptionEvent.topAnchor.constraint(equalTo: photosContainerView.bottomAnchor, constant: 16),
            descriptionEvent.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionEvent.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            descriptionEvent.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(huperTextView)
        
        NSLayoutConstraint.activate([
            huperTextView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            huperTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            huperTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            huperTextView.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        view.addSubview(participsntsView)
        
        NSLayoutConstraint.activate([
            participsntsView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -148),
            participsntsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            participsntsView.widthAnchor.constraint(equalTo: view.widthAnchor),
            participsntsView.heightAnchor.constraint(equalToConstant: 68)
        ])
        
        participsntsView.addSubview(participantsCountStackView)
        
        NSLayoutConstraint.activate([
            participantsCountStackView.topAnchor.constraint(equalTo: participsntsView.topAnchor, constant: 16),
            participantsCountStackView.leadingAnchor.constraint(equalTo: participsntsView.leadingAnchor, constant: 20),
            participantsCountStackView.widthAnchor.constraint(equalToConstant: 200),
            participantsCountStackView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        participsntsView.addSubview(participsntsCounter)
        participsntsCounter.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            participsntsCounter.centerYAnchor.constraint(equalTo: participsntsView.centerYAnchor),
            participsntsCounter.leadingAnchor.constraint(equalTo: participantsCountStackView.trailingAnchor, constant: 10),
            participsntsCounter.widthAnchor.constraint(equalToConstant: 36),
            participsntsCounter.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

// MARK: - SwiftUI Canvas
import SwiftUI
struct NewProvider: PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
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
