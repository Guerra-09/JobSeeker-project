//
//  TabBarController.swift
//  Project
//
//  Created by José Guerra on 14-03-23.
//
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setUpVC()
    }
    
    func createViewController(for root: UIViewController, title: String, sfSymbol: String) -> UIViewController {
        let navViewController = UINavigationController(rootViewController: root)
        navViewController.tabBarItem.title = title
        navViewController.tabBarItem.image = UIImage(systemName: sfSymbol)
        navViewController.navigationBar.prefersLargeTitles = true
        
        root.navigationItem.title = title
        
        return navViewController
    }
    
    private func setUpVC() {
        setViewControllers([createViewController(for: CategoryController(presenter: ListPresenter(listCompany: CompanyService(), listCategory: CategoryService(), listOffers: JobOffersService())), title: "Categories", sfSymbol: "list.bullet.clipboard"), createViewController(for: CompanyController(presenter: ListPresenter(listCompany: CompanyService(), listCategory: CategoryService(), listOffers: JobOffersService())), title: "Companies", sfSymbol: "building.2")], animated: true)
    }
    
}
