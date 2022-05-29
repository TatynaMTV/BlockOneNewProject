//
//  TabBarViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 12.03.2022.
//

import UIKit

class TabBarController: UITabBarController {
  // Middle button
  var tabBarWidth: CGFloat { tabBar.bounds.width }
  var tabBarHeight: CGFloat { tabBar.bounds.height }
  var centerWidth: CGFloat { tabBar.bounds.width / 2 }
  var circleRadius: CGFloat = 26
  var shapeLayer: CALayer?
  var circleLayer: CALayer?
  
  let middleButton = UIButton()
  let buttonImage = UIImageView()
  let middleButtonDiameter: CGFloat = 42
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
    setupMiddleButton()
    drawMiddleButton()
    setupNavigationBar()
    setConstraints()
  }
  
  private func setupTabBar() {
    let vc1 = UIViewController()
    let vc2 = UIViewController()
    let vcMiddle = AidCategoryViewController()
    let vc3 = UIViewController()
    let vc4 = UIViewController()
    
    viewControllers = [
      generateNavigationController(rootViewController: vc1, title: "Новости", image: UIImage(systemName: "list.bullet")),
      generateNavigationController(rootViewController: vc2, title: "Поиск", image: UIImage(systemName: "magnifyingglass")),
      generateNavigationController(rootViewController: vcMiddle, title: "Помочь", image: UIImage(systemName: "")),
      generateNavigationController(rootViewController: vc3, title: "История", image: UIImage(systemName: "clock.arrow.circlepath")),
      generateNavigationController(rootViewController: vc4, title: "Профиль", image: UIImage(systemName: "person.crop.circle"))
    ]
    
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    tabBar.standardAppearance = appearance
    tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    tabBar.tintColor = .greenLeaf()
    UITabBar.appearance().barTintColor = .white
  }
  
  // MARK: - Setup Navigation Controller & Navigation BAr
  
  private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
    let navigationVC = UINavigationController(rootViewController: rootViewController)
    navigationVC.tabBarItem.title = title
    navigationVC.tabBarItem.image = image
    return navigationVC
  }
  
  func setupNavigationBar() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 21, weight: .bold)]
    appearance.backgroundColor = .greenLeaf()
    UIWindow.appearance().overrideUserInterfaceStyle = .light
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    
  }
  
  // MARK: - Middle button
  
  func setupMiddleButton() {
    
    middleButton.layer.cornerRadius = middleButtonDiameter/2
    middleButton.backgroundColor = .greenLeaf()
    middleButton.translatesAutoresizingMaskIntoConstraints = false
    
    buttonImage.image = UIImage(systemName: "heart.fill")
    buttonImage.tintColor = .white
    buttonImage.translatesAutoresizingMaskIntoConstraints = false
    
    middleButton.addTarget(self, action: #selector(didPressMiddleButton(sender:)), for: .touchUpInside)
  }
  
  // MARK: - Actions
  
  @objc private func didPressMiddleButton(sender: UIButton) {
    selectedIndex = 2
    middleButton.backgroundColor = .greenLeaf()
  }
  
  private func shapePath() -> CGPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: tabBarWidth, y: 0))
    //    path.addLine(to: CGPoint(x: tabBarWidth, y: tabBarHeight))
    //    path.addLine(to: CGPoint(x: 0, y: tabBarHeight))
    path.close()
    return path.cgPath
  }
  
  private func circlePath() -> CGPath {
    let path = UIBezierPath()
    path.addArc(withCenter: CGPoint(x: centerWidth, y: 12),
                radius: circleRadius,
                startAngle: 180 * .pi / 180,
                endAngle: 0 * 180 / .pi,
                clockwise: true)
    return path.cgPath
  }
  
  private func drawMiddleButton() {
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = shapePath()
    shapeLayer.strokeColor = UIColor.lightGray.cgColor
    shapeLayer.fillColor = UIColor.white.cgColor
    shapeLayer.lineWidth = 1.0
    
    let circleLayer = CAShapeLayer()
    circleLayer.path = circlePath()
    circleLayer.strokeColor = UIColor.lightGray.cgColor
    circleLayer.fillColor = UIColor.white.cgColor
    circleLayer.lineWidth = 1.0
    
    if let oldShapeLayer = self.shapeLayer {
      tabBar.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
    } else if let oldShapeLayer = self.circleLayer {
      tabBar.layer.replaceSublayer(oldShapeLayer, with: circleLayer)
    } else {
      tabBar.layer.insertSublayer(shapeLayer, at: 0)
      tabBar.layer.insertSublayer(circleLayer, at: 1)
    }
  }
  
  // MARK: - Set constraints
  
  func setConstraints() {
    
    middleButton.addSubview(buttonImage)
    
    NSLayoutConstraint.activate([
      buttonImage.heightAnchor.constraint(equalToConstant: 15),
      buttonImage.widthAnchor.constraint(equalToConstant: 18),
      buttonImage.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
      buttonImage.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
    ])
    
    tabBar.addSubview(middleButton)
    
    NSLayoutConstraint.activate([
      middleButton.heightAnchor.constraint(equalToConstant: middleButtonDiameter),
      middleButton.widthAnchor.constraint(equalToConstant: middleButtonDiameter),
      middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
      middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)
    ])
    
  }
}

// MARK: - TabBarController Delegate

extension TabBarController: UITabBarControllerDelegate {
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    let selectedIndex = self.tabBar.items?.firstIndex(of: item)
    if selectedIndex != 2 {
      middleButton.backgroundColor = .melon()
    } else {
      middleButton.backgroundColor = .greenLeaf()
    }
  }
}

// MARK: - SwiftUI Canvas

import SwiftUI
struct TabBarProvider: PreviewProvider {
  static var previews: some View {
    ContainterView().edgesIgnoringSafeArea(.all)
  }
  
  struct ContainterView: UIViewControllerRepresentable {
    
    let tabBarController = TabBarController()
    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarProvider.ContainterView>) -> TabBarController {
      return tabBarController
    }
    
    func updateUIViewController(_ uiViewController: TabBarProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<TabBarProvider.ContainterView>) {
    }
  }
}
