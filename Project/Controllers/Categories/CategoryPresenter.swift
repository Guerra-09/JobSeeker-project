//
//  CategoryPresenter.swift
//  Project
//
//  Created by José Guerra on 15-03-23.
//

import Foundation

class CategoryPresenter {
    
    private var apiService: ApiHandler?
    
    init(apiService: ApiHandler? = nil) {
        self.apiService = apiService
    }
    
    func requestData(completionHandler: @escaping (ModelHandler?, Error?) -> Void) {
        
        apiService?.fetchingAPIData { model, error in
            
            if let model = model {
                completionHandler(model, nil)
            } else {
               completionHandler(nil, error)
            }
            
        }
    }
}
