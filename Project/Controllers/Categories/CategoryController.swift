//
//  CategoryController.swift
//  Project
//
//  Created by José Guerra on 14-03-23.
//

import UIKit

class CategoryController: UIViewController {
    
    // MARK: - Variables
    
    var model: ModelHandler?
    
    
    
    // MARK: - Components
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        return tableView
    }()

    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "Categories"
        
        self.loadApi()
        self.setupUI()
        
//        DispatchQueue.main.async { [weak self] in
//
//            self?.tableView.delegate = self
//            self?.tableView.dataSource = self
//        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
                 tableView.deselectRow(at: indexPath, animated: true)
            }
    }
    
    // MARK: - Setup UI
    
    private func loadApi() {
        let presenter = CategoryPresenter(apiService: ApiHandler())
        presenter.requestData { model, error in

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
//        let vc = OfferViewController()
//        vc.offerTitle = self.model?.data[indexPath.row]
//        present(vc, animated: true)
        
        
        
        let vc = OfferViewController()
        vc.offerTitle = self.model?.data[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
    

}
