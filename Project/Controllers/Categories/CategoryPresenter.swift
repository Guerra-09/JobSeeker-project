//
//  CategoryPresenter.swift
//  Project
//
//  Created by José Guerra on 15-03-23.
//

import Foundation

final class CategoryPresenter {
    
    private weak var view: CategoryControllerProtocol?
    private var categoryUseCase: CategoryService?
    private var categoryList: CategoryService?
    
    init(categoryUseCase: CategoryService? = nil) {
        self.categoryUseCase = categoryUseCase
    }
    
    func attach(view: CategoryControllerProtocol) {
        self.view = view
    }
    
    func requestCategories(completionHandler: @escaping (CategoryHandler?, Error?) -> Void) {
        
        categoryUseCase?.fetchCategories { model, error in
            
            if let model = model {
                completionHandler(model, nil)
                
            } else {
                completionHandler(nil, error)
            }
        }
    }
}
