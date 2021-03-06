//
//  CharityEventsViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 22.03.2022.
//

import UIKit

class CharityEventsViewController: UIViewController {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .lightGrey()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let barButtonItem: UIButton = {
        let barButton = UIButton.init(type: .custom)
        barButton.setBackgroundImage(UIImage(named: "filter"), for: .normal)
        barButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        barButton.tintColor = .white
        return barButton
    }()
    
    private var segmentedControl = UISegmentedControl()
    
    private let cellID = "CharityEvent"
    private let items = ["Текущие", "Завершенные"]
    
    private let titlePhoto: [UIImage] = [
        UIImage(named: "image1"),
        UIImage(named: "image2")
    ].compactMap({ $0 })
    
    let eventData = DataLoader().loadEvent(fileName: "event")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGrey()
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backItem?.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButtonItem)
        
        segmentedControl.addTarget(self, action: #selector(changedValue), for: .valueChanged)
        
        setupViews()
        setConstraints()
    }
    
    @objc private func changedValue() {
        print("Changed")
    }
}

// MARK: - DataSource & Delegate

extension CharityEventsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CharityEventCollectionViewCell // swiftlint:disable:this force_cast
        let model = eventData?[indexPath.row]
        cell.titleLabel.text = model?.name
        cell.textLabel.text = model?.info
        cell.bottomDateLabel.text = model?.time
        cell.imageView.image = UIImage(named: model?.image ?? "image1")
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = eventData?[indexPath.row]
        let detailVC = DetailCharityEventViewController()
        
        detailVC.title = model?.name
        detailVC.titleNameLabel.text = model?.name
        detailVC.countdownTimerLabel.text = model?.time
        detailVC.fondNameLable.text = model?.fond
        detailVC.addressLabel.text = model?.address
        detailVC.phoneLabel.text = model?.phone
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - DelegateFlowLayout

extension CharityEventsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width - 32
        let height = CGFloat(413)
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - Create UI elements & set constraints

extension CharityEventsViewController {
    
    private func setupViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharityEventCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .greenLeaf()
        segmentedControl.tintColor = .white
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.greenLeaf()!], for: .selected)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        view.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        backView.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
