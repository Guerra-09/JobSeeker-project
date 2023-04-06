//
//  CompanyPresenter.swift
//  Project
//
//  Created by José Guerra on 21-03-23.
//

import Foundation
import UIKit

class CompanyUseCase {
    
    private var companyApi: CompanyService?
    
    init(companyApi: CompanyService? = nil) {
        self.companyApi = companyApi
    }
    
    func requestData(completionHandler: @escaping (CompanyHandler?, Error?) -> Void) {
        
        companyApi?.fetchingAPIData { model, error in
            
            if let model = model {
                completionHandler(model, nil)
            } else {
               completionHandler(nil, error)
            }
            
        }
        
    }

    
}

