//
//  TabBarViewController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 12.03.2022.
//

import UIKit

class TabBarController: UITabBarController {
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

  func setupTabBar() {
    let vc1 = UIViewController()
    let vc2 = UIViewController()
    let vcMiddle = HelpCategoriesViewController()
    let vc3 = UIViewController()
    let vc4 = UIViewController()

    vc1.title = "Новости"
    vc2.title = "Поиск"
    vc3.title = "История"
    vc4.title = "Профиль"

    let nav1 = UINavigationController(rootViewController: vc1)
    let nav2 = UINavigationController(rootViewController: vc2)
    let nav = UINavigationController(rootViewController: vcMiddle)
    let nav3 = UINavigationController(rootViewController: vc3)
    let nav4 = UINavigationController(rootViewController: vc4)

    nav1.tabBarItem = UITabBarItem(title: "Новости", image: UIImage(systemName: "list.bullet"), tag: 2)
    nav2.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 3)
    nav.tabBarItem = UITabBarItem(title: "Помочь", image: UIImage(systemName: ""), tag: 1)
    nav3.tabBarItem = UITabBarItem(title: "История", image: UIImage(systemName: "clock.arrow.circlepath"), tag: 4)
    nav4.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.crop.circle"), tag: 5)

    setViewControllers([nav1, nav2, nav, nav3, nav4], animated: false)

    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    tabBar.standardAppearance = appearance
    tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    tabBar.tintColor = .greenLeaf()
  }

  // MARK: - Setup Navigation Bar

  func setupNavigationBar() {
    UITabBar.appearance().barTintColor = .white
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "OfficinaSansExtraBoldSCC", size: 21) ?? UIFont.systemFont(ofSize: 21, weight: .semibold)]
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
    print("tap")
    selectedIndex = 2
  }

  private func shapePath() -> CGPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: tabBarWidth, y: 0))
    path.addLine(to: CGPoint(x: tabBarWidth, y: tabBarHeight))
    path.addLine(to: CGPoint(x: 0, y: tabBarHeight))
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
    shapeLayer.lineWidth = 0.0

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
    tabBar.addSubview(middleButton)

    NSLayoutConstraint.activate([
      middleButton.heightAnchor.constraint(equalToConstant: middleButtonDiameter),
      middleButton.widthAnchor.constraint(equalToConstant: middleButtonDiameter),
      middleButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
      middleButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)
    ])

    middleButton.addSubview(buttonImage)

    NSLayoutConstraint.activate([
      buttonImage.heightAnchor.constraint(equalToConstant: 15),
      buttonImage.widthAnchor.constraint(equalToConstant: 18),
      buttonImage.centerXAnchor.constraint(equalTo: middleButton.centerXAnchor),
      buttonImage.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor)
    ])
  }
}
