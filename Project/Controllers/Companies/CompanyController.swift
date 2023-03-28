//
//  CompanyController.swift
//  Project
//
//  Created by José Guerra on 14-03-23.
//

import UIKit

class CompanyController: UIViewController {
    
    // MARK: - Variables
    
    var companies: [CompanyModel]?
    var testVariable: [String]?
    
    
    
    // MARK: - Components
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.identifier)
        return tableView
    }()
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
     
        self.loadApi()
        self.setupUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    

    
    
    
    // MARK: - Setup UI
    
    private func loadApi() {
        
        let presenter = CompanyPresenter(companyApi: CompanyService())
        
        presenter.requestData { model, error in
            if let error = error {
                print(error)
            } else {
                print("CompanyController: \(model?.data.count ?? 0)")
                
            }
            
            guard model?.data != nil else {
                self.companies = model?.data
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

extension CompanyController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return self.companies?.count ?? 3
        return self.testVariable?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCell.identifier, for: indexPath) as? CompanyCell else {
            fatalError("ERROR: problema con el uitableviewcell")
        }
                
        cell.textLabel?.text = "testing"
        
        //cell.textLabel?.text = self.testVariable![indexPath.row]
        //cell.textLabel?.text = "\(String(describing: self.model?.data[indexPath.row]))"
        return cell
    }
}
