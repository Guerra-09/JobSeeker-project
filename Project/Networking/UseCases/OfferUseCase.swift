//
//  OfferPresenter.swift
//  Project
//
//  Created by José Guerra on 22-03-23.
//

import Foundation
import UIKit

final class OfferUseCase {
    
    private weak var view: ListControllerProtocol?
    private var offersList: JobOffersService?
    
    init(offersList: JobOffersService) {
        self.offersList = offersList
    }
    
    func attach(view: ListControllerProtocol) {
        self.view = view
    }
    
    func requestData(jobId: String ,completionHandler: @escaping (JobOfferHandler?, Error?) -> Void) {
        
        // The problem is that this function below is not calling the service correctly, for any reason
        // is just dying
        offersList?.fetchingOffersData(jobId: jobId, completionHandler: { model, error in
            
            if let model = model {
                completionHandler(model, nil)
                
            } else {
                completionHandler(nil, error)
            }
            
        })
        
       

    }
}

