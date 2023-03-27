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
    
    private let offerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .infinity)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "placeholder"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let titleLabel: UILabel = {
        let labelText = UILabel()
        labelText.text = "placeholder"
        labelText.translatesAutoresizingMaskIntoConstraints = false
        return labelText
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = self.offerTitle?.name
        //titleLabel.text = self.offerTitle?.name
    
        self.loadJobOffers()
     
        
    }
    
    
    // MARK: - Setting UP View
    
    func setUpView(offerInfo: [String]) {
        
        view.backgroundColor = UIColor.red
        view.addSubview(titleLabel)
        view.addSubview(offerNameLabel)
        view.addSubview(detailsLabel)
        
        titleLabel.text = offerInfo[0]
        detailsLabel.text = offerInfo[1]

        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: offerNameLabel.topAnchor),
            
            offerNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            offerNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            offerNameLabel.bottomAnchor.constraint(equalTo: detailsLabel.topAnchor),

            detailsLabel.topAnchor.constraint(equalTo: offerNameLabel.bottomAnchor),
            detailsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            detailsLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
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

                self.offerData?.data.forEach({
                    self.setUpView(offerInfo: [$0.title, $0.description])
                })
                    return
            }
        }
    }
    
    

    
}



