//
//  CharityEventsViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 18.03.2022.
//

import UIKit

class CharityEventsViewController: UIViewController {

  var segmentedControl = UISegmentedControl()
  
  let items = ["Текущие", "Завершенные"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    segmentedControl.addTarget(self, action: #selector(segmentValChanged(_:)), for: .valueChanged)

    setupViews()
    setConstraints()

  }
  
  @objc func segmentValChanged(_ sender: UISegmentedControl) {
    print("touched")
  }
}

extension CharityEventsViewController {
  // Set View
  private func setupViews() {
    view.backgroundColor = .white

    segmentedControl = UISegmentedControl(items: items)
    segmentedControl.selectedSegmentIndex = 0
    segmentedControl.backgroundColor = .greenLeaf()
    segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.greenLeaf() ?? UIColor.black], for: .selected)
    segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
  }

  // Set contrains
  private func setConstraints() {
    view.addSubview(segmentedControl)
    
    NSLayoutConstraint.activate([
      segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      segmentedControl.heightAnchor.constraint(equalToConstant: 24)
    ])
  }
}
