//
//  CategoryController.swift
//  Project
//
//  Created by José Guerra on 14-03-23.
//

import UIKit

class CategoryController: UIViewController {
    
    // MARK: - Variables
    
    private var model: CategoryHandler?
    private var presenter: CategoryPresenter?
    
    
    
    // MARK: - Components

    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        return tableView
    }()

    
    
    
    // MARK: - LifeCycle
    
    convenience init(presenter: CategoryPresenter? = nil) {
        self.init()
        self.presenter = presenter
        self.presenter?.attach(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadApi()
        self.setupUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /// Remember: Esta linea de codigo deseleciona las celdas al carga la view
        if let indexPath = self.tableView.indexPathForSelectedRow {
                 tableView.deselectRow(at: indexPath, animated: true)
            }
        
    }
    
    // MARK: - Setup UI
    
    private func loadApi() {
    
        let presenter = CategoryPresenter(categoryUseCase: CategoryService())
        presenter.requestCategories { model, error in

            if let error = error {
                print(error)
            } else {
                // Running perfectly
            }
    
            
            guard model == nil else {
                
                self.model = model
                self.tableView.reloadData()
                
                return
            }
        }
    }
    
    
    
    private func setupUI() {
        self.view.backgroundColor = .systemBlue
        self.navigationItem.title = "Categories"
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    
    
    
}



extension CategoryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.data.count ?? 1
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            fatalError("ERROR: problema con el uitableviewcell")
        }
        
        let categoryModel = self.model?.data
        cell.textLabel?.text = "\(categoryModel?[indexPath.row].name ?? "null")"
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OfferViewController()
        vc.offerTitle = self.model?.data[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
    

}


extension CategoryController: CategoryControllerProtocol {
    func showList(list: CategoryHandler) {
        self.model = list
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    

    
    
    
    func showOfferList(model: [JobOfferModel]) {}
    
    func showCompanyList(model: [CompanyModel]) {}
    
    func errorList() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}
