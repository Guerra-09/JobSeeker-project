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
        
        let categoryController = CategoryController()
        let companyController = CompanyController()
        
        categoryController.title = "Categories"
        companyController.title = "Companies"
        
        categoryController.navigationItem.title = "gola"
        categoryController.navigationItem.largeTitleDisplayMode = .always
        
        self.setViewControllers([categoryController, companyController], animated: false)
        
        guard let items = self.tabBar.items else { return }
        let images = ["square.fill.text.grid.1x2", "building.2.fill"]
        
        for x in 0...1 {
            items[x].image = UIImage(systemName: images[x])
        }
        
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        
        
    }
    
}
