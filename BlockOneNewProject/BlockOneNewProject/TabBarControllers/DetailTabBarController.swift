//
//  DetailTabBarController.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 25.05.2022.
//

import UIKit

class DetailTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 100)
        setupTabBar()
        setupNavigationBar()
    }
    
    private func setupTabBar() {
        
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        let vc4 = UIViewController()
        
        viewControllers = [
            generateNavigationController(rootViewController: vc1, title: "Помочь вещами", image: UIImage(named: "shirt")),
            generateNavigationController(rootViewController: vc2, title: "Стать Волонтером", image: UIImage(named: "hands")),
            generateNavigationController(rootViewController: vc3, title: "Проф. помощь", image: UIImage(named: "tools")),
            generateNavigationController(rootViewController: vc4, title: "Помочь деньгами", image: UIImage(named: "coins"))
        ]
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        tabBar.tintColor = .greenLeaf()
        UITabBar.appearance().barTintColor = .white
        
        var index: CGFloat = 4
        for _ in 0..<3 {
            let verticalLine = CALayer()
            if index == 3 {
                verticalLine.frame = CGRect(x: self.tabBar.frame.width - self.tabBar.frame.width / 4, y: 0, width: 2, height: self.tabBar.frame.height)
            } else {
                verticalLine.frame = CGRect(x: self.tabBar.frame.width / index, y: 0, width: 2, height: self.tabBar.frame.height)
            }
            verticalLine.backgroundColor = UIColor(red: 232/255, green: 237/255, blue: 237/255, alpha: 0.7).cgColor
            self.tabBar.layer.addSublayer(verticalLine)
            index -= 1
//            print(index)
        }
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
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 100
        return sizeThatFits
    }
}

// MARK: - SwiftUI Canvas

import SwiftUI
struct TabBarNewProvider: PreviewProvider {
  static var previews: some View {
    ContainterView().edgesIgnoringSafeArea(.all)
  }
  
  struct ContainterView: UIViewControllerRepresentable {
    
    let tabBarNewController = DetailTabBarController()
    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarNewProvider.ContainterView>) -> DetailTabBarController {
      return tabBarNewController
    }
    
    func updateUIViewController(_ uiViewController: TabBarNewProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<TabBarNewProvider.ContainterView>) {
    }
  }
}
