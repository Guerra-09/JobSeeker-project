//
//  ApiService.swift
//  Project
//
//  Created by José Guerra on 14-03-23.
//

import Foundation
import Alamofire

class CategoryService {
    
    var categoryDelegate: CategoryControllerProtocol?
    
    func fetchCategories(completionHandler: @escaping (CategoryHandler?, Error?) -> Void) {
        let url = "https://www.getonbrd.com/api/v0/categories?per_page=20&page=1"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            
            switch response.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode(CategoryHandler.self, from: data!)
                    completionHandler(jsondata, nil)
                    
                } catch {
                    print(String(describing: error))
                    completionHandler(nil, error)
                }
            
            case .failure(let error):
                //print(error.localizedDescription)
                print(String(describing: error))
                completionHandler(nil, error)
                
            }
        }
        
    }
    
    
}

