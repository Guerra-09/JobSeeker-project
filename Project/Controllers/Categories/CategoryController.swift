//
//  CategoryController.swift
//  Project
//
//  Created by José Guerra on 14-03-23.
//

import UIKit
import Foundation

class CategoryController: UIViewController {
    
    // MARK: - Variables
    private var presenter: ListPresenter?
    private var model: [CategoryModel]?
    
    convenience init(presenter: ListPresenter? = nil) {
        self.init()
        self.presenter = presenter
        self.presenter?.attach(view: self)
    }
    
    
    // MARK: - Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        return tableView
    }()
    
    
    private let spinnerView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.showCategoryList()
        
    }
    
    // MARK: - Setup UI

    private func setupUI() {
        
        self.view.addSubview(tableView)
        self.view.addSubview(spinnerView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            spinnerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            
        ])
    }
    
    
}



extension CategoryController: UITableViewDelegate {
        
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let id = model?[indexPath.row].id else { return }
        
        var viewController = OfferViewController(presenter: ListPresenter(listCompany: CompanyService(), listCategory: CategoryService(), listOffers: JobOffersService()))
                                                 
        viewController.jobSelected = id
        viewController.jobTitle = self.model?[indexPath.row].name
        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension CategoryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.model?.count ?? 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            fatalError("ERROR: problema con el uitableviewcell")
        }
        
        let categoryModel = self.model
        
        if let categoryModel = categoryModel {

            cell.textLabel?.text = "\(categoryModel[indexPath.row].name)"
            spinnerView.stopAnimating()
            
        } else {
            spinnerView.startAnimating()
        }
        
        return cell
    }

}


extension CategoryController: ListControllerProtocol {
    
    func listSuccess(model: [CompanyModel]) { }
    func offerSuccess(model: [JobOfferModel]) { }
    
    func categorySuccess(model: [CategoryModel]) {
        self.model = model
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func errorList() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
