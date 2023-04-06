//
//  OfferPresenter.swift
//  Project
//
//  Created by José Guerra on 22-03-23.
//

import Foundation
import UIKit

class OfferUseCase {
    
    private var offerDelegate: JobOfferService?
    
    init(offerDelegate: JobOfferService? = nil) {
        self.offerDelegate = offerDelegate
    }
    
    func requestData(jobId: String ,completionHandler: @escaping (JobOfferHandler?, Error?) -> Void) {
        
        offerDelegate?.fetchingOffersData(jobId: jobId) { model, error in
            
            if let model = model {
                completionHandler(model, nil)
            } else {
               completionHandler(nil, error)
            }
        }
    }
}

