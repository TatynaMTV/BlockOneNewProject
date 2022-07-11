//
//  CharityEventsViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 22.03.2022.
//

import UIKit
import RealmSwift
import Alamofire

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
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .gray
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private var segmentedControl = UISegmentedControl()
    
    private let cellID = "CharityEvent"
    private let items = ["Текущие", "Завершенные"]
    
    // variable responsible for the database
    var events = [EventModel]()
    let service = DatabaseService()
    let loadLocalData = DataLoader()
    let urlFireDatabase = "https://blockonenewproject-default-rtdb.firebaseio.com/Events/.json"
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGrey()
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backItem?.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButtonItem)
        
        // load data from Firebase whith URLSession
        service.loadDataFB(type: EventModel.self, urlString: urlFireDatabase) { [weak self] result in
            switch result {
            case .success(let events):
                self?.events = events
                self?.spinner.stopAnimating()
                self?.collectionView.reloadData()
                print("My events: \(events)")
            case .failure(let error):
                print("error:", error)
                self?.loadLocalData.getCategoryType(type: EventModel.self, fileName: "event", format: "json") { [weak self] result in
                    switch result {
                    case .success(let events):
                        self?.events = events!
                        DispatchQueue.main.async {
                            self?.spinner.stopAnimating()
                            self?.collectionView.reloadData()
                        }
                    case .failure(let error):
                        print("error:", error)
                    }
                }
            }
        }
        
        // load data from Firebase whith Alamofire
//        AF.request(urlFireDatabase).validate(statusCode: 200..<300).responseDecodable(of: [EventModel].self, decoder: decoder) { response in
//            switch response.result {
//            case .success(let events):
//                self.events = events
//                DispatchQueue.main.async {
//                    self.spinner.stopAnimating()
//                    self.collectionView.reloadData()
//                }
//                print("items", events)
//            case .failure(let error):
//                print("error", error.localizedDescription)
//            }
//        }
        
        setupViews()
        setConstraints()
    }
}

// MARK: - DataSource & Delegate

extension CharityEventsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CharityEventCollectionViewCell // swiftlint:disable:this force_cast
        let model = events[indexPath.row]
        cell.titleLabel.text = model.name
        cell.textLabel.text = model.info
        cell.bottomDateLabel.text = model.time
        cell.imageView.image = UIImage(named: model.image)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailCharityEventViewController()
        let model = events[indexPath.row]
        
        detailVC.title = model.name
        detailVC.titleNameLabel.text = model.name
        detailVC.countdownTimerLabel.text = model.time
        detailVC.fondNameLable.text = model.fond
        detailVC.addressLabel.text = model.address
        detailVC.phoneLabel.text = model.phone
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
