//
//  CompanyController.swift
//  Project
//
//  Created by José Guerra on 14-03-23.
//

import UIKit

class CompanyController: UIViewController {
    
    // MARK: - Variables
    
    private var presenter: ListPresenter?
    private var model: [CompanyModel]?
    
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.showCompanyList()
    }
    
    

    
    
    
    // MARK: - Setup UI
    
    private func loadApi() {

        let api = CompanyUseCase(companyApi: CompanyService())

            api.requestData { model, error in
            if let error = error {
                print(error)
            } else {
                guard let modelData = model else { return }
                self.model = modelData.data
                self.tableView.reloadData()
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

extension CompanyController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = model else { return }
        
        let alert = UIAlertController(title: model[indexPath.row].id, message: "Empresa \(model[indexPath.row].name)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    
    }
}

extension CompanyController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if model != nil {
            return self.model?.count ?? 0
            //return 1
            
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCell.identifier, for: indexPath) as? CompanyCell else {
            fatalError("ERROR: problema con el uitableviewcell")
        }
            
        
        cell.configure(with: "\(self.model?[indexPath.row].logo ?? "aaa")", and: "\(self.model?[indexPath.row].name ?? "nombre = null")")
        
        return cell
    }
}

extension CompanyController: ListControllerProtocol {
    func categorySuccess(model: [CategoryModel]) {}
    
    func offerSuccess(model: [JobOfferModel]) {}
    
    
    func listSuccess(model: [CompanyModel]) {
        self.model = model
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    
    }
    
    func errorList() {
        let alert = UIAlertController(title: "Error", message: "ups", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
