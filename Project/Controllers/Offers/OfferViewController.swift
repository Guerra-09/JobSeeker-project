//
//  OfferViewController.swift
//  Project
//
//  Created by José Guerra on 20-03-23.
//

import Foundation
import UIKit

class OfferViewController: UIViewController {
    
    
    // MARK: - Variables
    private var presenter: ListPresenter?
    private var model: [JobOfferModel]?
    
    var jobTitle: String?
    var jobSelected: String?
    
    convenience init(presenter: ListPresenter? = nil) {
        self.init()
        self.presenter = presenter
        self.presenter?.attach(view: self)
    }
    
    
    
    
    // MARK: - Components
    
    private let offerTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(OfferCell.self, forCellReuseIdentifier: OfferCell.identifier)
        return tableView
    }()
    
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = self.jobTitle
        
        DispatchQueue.main.async { [weak self] in
            self?.offerTableView.delegate = self
            self?.offerTableView.dataSource = self
        }
        
        self.setUpView()
        self.loadApi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.showOffersCategory(type: "\(self.jobSelected!)")
    }
    
    
    // MARK: - Setting UP View
    
    private func loadApi() {
        
        let categoryApi = OfferUseCase(offersList: JobOffersService())
        
        categoryApi.requestData(jobId: self.jobSelected ?? "nil", completionHandler: { model, error in
            
            if let error = error {
                print(error)
                
            } else {
                guard let modelData = model else { return }
                self.model = modelData.data
                self.offerTableView.reloadData()
                
            }
            
        })
        
        
    }
    
    func setUpView() {
        
        view.addSubview(offerTableView)
        
        offerTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            offerTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            offerTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            offerTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            offerTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
    }
    
    
    // MARK: - Methods
    
    func downloadImageFromInternet(urlFromInternet: String) -> UIImage {
        let url = URL(string: urlFromInternet)!
        let session = URLSession(configuration: .default)
        var imageFinal = UIImage()

        
        let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {
                if response is HTTPURLResponse {

                    if let imageData = data {
                        imageFinal = UIImage(data: imageData) ?? UIImage()
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }

        downloadPicTask.resume()
        return imageFinal
    }
    
    
    
    
}



extension OfferViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let offerDetailVC = OfferDetailsViewController()
        offerDetailVC.jobInfo = self.model?[indexPath.row]
        navigationController?.pushViewController(offerDetailVC, animated: true)
        
    }
}


extension OfferViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OfferCell.identifier, for: indexPath) as? OfferCell else {
            fatalError("ERROR: problema con el uitableviewcell")
        }
        
        let offerModel = self.model
        var configuration = UIListContentConfiguration.cell()
        configuration.text = "\(offerModel?[indexPath.row].title ?? "null")"
        
        
        // This line sets up the seniority level of the offer
        var seniorityPlaceholder = String()
        
        self.model?.forEach({ index in
            
            if index.seniority.id == 1 {
                seniorityPlaceholder = "Sin Experiencia"
                
            } else if index.seniority.id == 2 {
                seniorityPlaceholder = "Junior"
                
            } else if index.seniority.id == 3 {
                seniorityPlaceholder = "Semi Senior"
                
            } else if index.seniority.id == 4 {
                seniorityPlaceholder = "Senior"
                
            } else if index.seniority.id == 5 {
                seniorityPlaceholder = "Expert"
                
            } else {
                seniorityPlaceholder = "not specified"
            }
        })
        
        // This line sets up the name of the company
        configuration.secondaryText = "Seniority: \(seniorityPlaceholder) \n\(self.model?[indexPath.row].company.name ?? "null")"
        
        configuration.image = downloadImageFromInternet(urlFromInternet: self.model?[indexPath.row].company.logo ?? "null")
        
        cell.contentConfiguration = configuration
        
        return cell
    }
}


extension OfferViewController: ListControllerProtocol {
    func listSuccess(model: [CompanyModel]) {}
    
    func categorySuccess(model: [CategoryModel]) {}
    
    func offerSuccess(model: [JobOfferModel]) {
        
        self.model = model
        
        DispatchQueue.main.async {
            //self.tab
        }
    }
    
    func errorList() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
