//
//  CategoryPresenter.swift
//  Project
//
//  Created by José Guerra on 15-03-23.
//

import Foundation

final class CategoryUseCase {
    
    private weak var view: ListControllerProtocol?
    private var categoryList: CategoryService?
    
    init(categoryList: CategoryService) {
        self.categoryList = categoryList
    }
    
    func attach(view: ListControllerProtocol) {
        self.view = view
    }
    
    func requestCategories(completionHandler: @escaping (CategoryHandler?, Error?) -> Void) {
        
        categoryList?.fetchCategories { model, error in
            
            if let model = model {
                completionHandler(model, nil)
                
            } else {
                completionHandler(nil, error)
            }
        }
    }
}
