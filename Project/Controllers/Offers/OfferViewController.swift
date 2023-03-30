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
    
    var offerTitle: CategoryModel?
    private var offerData: JobOfferHandler?
    
    
    
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
        
        navigationItem.title = self.offerTitle?.name
    
        self.loadJobOffers()
        
        DispatchQueue.main.async { [weak self] in
            self?.offerTableView.delegate = self
            self?.offerTableView.dataSource = self
        }
        
     
        
    }
    
    
    // MARK: - Setting UP View
    
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
    
    
    // Esta funcion trae la info de la api y la setea como parte del self.offerData
    func loadJobOffers() {
        
        let presenter = OfferPresenter(offerDelegate: JobOfferService())
        presenter.requestData(jobId: self.offerTitle?.id ?? "programming") { model, error in

            if let error = error {
                print(error)
            } else {
                
                guard let modelGet = model else { return }
                
                self.offerData = modelGet
                
                self.setUpView()
                
                    return
            }
        }
    }
    
    func downloadImageFromInternet(urlFromInternet: String) -> UIImage {
        let url = URL(string: urlFromInternet)!
        let session = URLSession(configuration: .default)
        var imageFinal = UIImage()

        
        let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    //print("Downloaded \(urlFromInternet) picture with response code \(res.statusCode)")
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
        return self.offerData?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let offerDetailVC = OfferDetailsViewController()
        offerDetailVC.jobInfo = self.offerData?.data[indexPath.row]
        navigationController?.pushViewController(offerDetailVC, animated: true)
        
    }
}


extension OfferViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OfferCell.identifier, for: indexPath) as? OfferCell else {
            fatalError("ERROR: problema con el uitableviewcell")
        }
        
        let offerModel = self.offerData?.data
        var configuration = UIListContentConfiguration.cell()
        configuration.text = "\(offerModel?[indexPath.row].title ?? "null")"
        
        
        // This line sets up the seniority level of the offer
        var seniorityPlaceholder = String()
        
        self.offerData?.data.forEach({ index in
            
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
        configuration.secondaryText = "Seniority: \(seniorityPlaceholder) \n\(self.offerData?.data[indexPath.row].company.name ?? "null")"
        
        configuration.image = downloadImageFromInternet(urlFromInternet: self.offerData?.data[indexPath.row].company.logo ?? "null")
        
        cell.contentConfiguration = configuration
        
        return cell
    }
}
